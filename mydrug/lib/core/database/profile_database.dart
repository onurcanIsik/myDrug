import 'package:sqflite/sqflite.dart' as sql;

class DrugSql {
  static Future<void> createTable(sql.Database database) async {
    await database.execute(""" CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      profileName TEXT,
      profileAge TEXT,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'profileData.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

//! CREATE PROFILE
  static Future<int> createProfile(
    String? profileName,
    String? profileAge,
  ) async {
    final db = await DrugSql.db();
    final data = {
      'profileName': profileName,
      'profileAge': profileAge,
    };
    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  //! GET PROFILE BY ID
  static Future<Map<String, dynamic>> getProfileById(int id) async {
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
    String profileName,
    String profileAge,
  ) async {
    final db = await DrugSql.db();

    final data = {
      'profileName': profileName,
      'profileAge': profileAge,
    };
    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
