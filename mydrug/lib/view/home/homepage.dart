// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrug/color/colors.dart';
import 'package:mydrug/core/database/drug_database.dart';
import 'package:mydrug/view/addDrug/add_drug.dart';
import 'package:mydrug/view/profile/profile.dart';
import 'package:mydrug/view/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> drugs = [];

  void refreshJournals() async {
    final data = await DrugSql.getDrugs();
    setState(() {
      drugs = data;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshJournals();
  }

  Future<void> deleteDrug(int id) async {
    await DrugSql.deleteDrug(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDrug()),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        leading: Image.asset("assets/images/mydrug_nobg.png"),
        centerTitle: true,
        title: Text(
          "MyDrug",
          style: GoogleFonts.bubblegumSans(
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                refreshJournals();
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: const Icon(
              Icons.person_3,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: drugs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Container(
              decoration: BoxDecoration(
                color: drkBlue,
                borderRadius: BorderRadius.circular(17),
              ),
              width: MediaQuery.of(context).size.width * 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(
                        base64Decode(
                          drugs[index]['drugImage'],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        drugs[index]['drugName'],
                        style: GoogleFonts.comfortaa(
                          fontSize: 20,
                          color: ligBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        drugs[index]['drugPurpose'],
                        style: GoogleFonts.comfortaa(
                          fontSize: 15,
                          color: ligBlue,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        drugs[index]['drugDate'],
                        style: GoogleFonts.comfortaa(
                          fontSize: 15,
                          color: ligBlue,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        drugs[index]['drugDuration'],
                        style: GoogleFonts.comfortaa(
                          fontSize: 15,
                          color: ligBlue,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditDrug(
                                      drugId: drugs[index]['id'],
                                    )),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: ligBlue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            deleteDrug(drugs[index]['id']).then(
                              (value) => Fluttertoast.showToast(
                                  msg: "Deleted drug", timeInSecForIosWeb: 3),
                            );
                            refreshJournals();
                          });
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          color: depPurp,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EditDrug extends StatefulWidget {
  final int drugId;
  const EditDrug({super.key, required this.drugId});

  @override
  State<EditDrug> createState() => _EditDrugState();
}

class _EditDrugState extends State<EditDrug> {
  Map<String, dynamic> drugData = {};

  @override
  void initState() {
    super.initState();
    fetchDrugData();
  }

  Future<void> fetchDrugData() async {
    final drug = await DrugSql.getDrugById(widget.drugId);
    setState(() {
      drugData = drug;
    });
  }

  TextEditingController updateDrugName = TextEditingController();
  TextEditingController updateDrugPurpose = TextEditingController();
  TextEditingController updateDrugDuration = TextEditingController();

  Future<void> updateDrugs(int id) async {
    await DrugSql.updateDrug(
      id,
      updateDrugName.text,
      updateDrugPurpose.text,
      updateDrugDuration.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AlertDialog(
                      title: Center(
                        child: Text("Edit MyDrugs"),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLength: 18,
                            controller: updateDrugName,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: drugData['drugName'],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLength: 18,
                            controller: updateDrugDuration,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: drugData['drugDuration'],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLength: 18,
                            controller: updateDrugPurpose,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: drugData['drugPurpose'],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              updateDrugs(drugData['id']);
                            });
                          },
                          child: Text(
                            "Update Drug",
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.edit_note_rounded,
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          "Edit Drug",
          style: GoogleFonts.bubblegumSans(
            fontSize: 22,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: drugData['drugImage'] != null
                    ? MemoryImage(
                        base64Decode(
                          drugData['drugImage'],
                        ),
                      ) as ImageProvider<Object>
                    : AssetImage('assets/images/mydrug_nobg.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Text(
                  "Drug Name: ${drugData['drugName']}",
                  style: GoogleFonts.comfortaa(
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Text(
                  "Drug Date: ${drugData['drugDate']}",
                  style: GoogleFonts.comfortaa(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Text(
                  "Drug Purpose: ${drugData['drugPurpose']}",
                  style: GoogleFonts.comfortaa(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Text(
                  "Drug Dur. : ${drugData['drugDuration']}",
                  style: GoogleFonts.comfortaa(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
