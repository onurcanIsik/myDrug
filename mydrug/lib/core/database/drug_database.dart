import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DrugSql {
  static Future<void> createTable(sql.Database database) async {
    await database.execute(""" CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      drugName TEXT,
      drugDate TEXT,
      drugPurpose TEXT,
      drugDuration TEXT,
      drugImage TEXT,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'drugData.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

//! CREATE DRUG
  static Future<int> createDrug(
    String? drugName,
    String? drugDate,
    String? drugPurpose,
    String? drugDuration,
    String? drugImage,
  ) async {
    final db = await DrugSql.db();
    final data = {
      'drugName': drugName,
      'drugDate': drugDate,
      'drugPurpose': drugPurpose,
      'drugDuration': drugDuration,
      'drugImage': drugImage
    };
    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

//! GET DRUG
  static Future<List<Map<String, dynamic>>> getDrugs() async {
    final db = await DrugSql.db();
    return db.query('items', orderBy: 'id');
  }

  //! GET DRUG BY ID
  static Future<Map<String, dynamic>> getDrugById(int id) async {
    final db = await DrugSql.db();
    final result = await db.query('items', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  //! UPDATE DRUG
  static Future<int> updateDrug(
    int id,
    String drugName,
    String drugPurpose,
    String drugDuration,
  ) async {
    final db = await DrugSql.db();

    final data = {
      'drugName': drugName,
      'drugPurpose': drugPurpose,
      'drugDuration': drugDuration,
    };
    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [id]);

    return result;
  }

//! DELETE DRUG
  static Future<void> deleteDrug(int id) async {
    final db = await DrugSql.db();
    try {
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item $err");
    }
  }

//! DELETE ALL DRUG
  static Future<void> deleteAllDrugs() async {
    final db = await DrugSql.db();
    await db.delete('items');
  }
}
