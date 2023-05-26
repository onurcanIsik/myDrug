import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydrug/core/database/drug_database.dart';

class AddDrug extends StatefulWidget {
  const AddDrug({super.key});

  @override
  State<AddDrug> createState() => _AddDrugState();
}

class _AddDrugState extends State<AddDrug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Drugs",
          style: GoogleFonts.bubblegumSans(
            fontSize: 22,
          ),
        ),
      ),
      body: const AddDrugColumn(),
    );
  }
}

class AddDrugColumn extends StatefulWidget {
  const AddDrugColumn({super.key});

  @override
  State<AddDrugColumn> createState() => _AddDrugColumnState();
}

class _AddDrugColumnState extends State<AddDrugColumn> {
  Future<String> pickImageAndConvertToBase64() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      return base64Image;
    }

    return '';
  }

  String base64Image = '';

  void pickImageAndConvert() async {
    try {
      final convertedImage = await pickImageAndConvertToBase64();
      setState(() {
        base64Image = convertedImage;
      });
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  TextEditingController drugNameController = TextEditingController();
  TextEditingController drugDateController = TextEditingController();
  TextEditingController drugPurposeController = TextEditingController();
  TextEditingController drugDurationController = TextEditingController();
  TextEditingController drugImageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> addDrug() async {
    await DrugSql.createDrug(
      drugNameController.text,
      drugDateController.text,
      drugPurposeController.text,
      drugDurationController.text,
      base64Image,
    );
  }

  List<Map<String, dynamic>> drugs = [];
  void refreshJournals() async {
    final data = await DrugSql.getDrugs();
    setState(() {
      drugs = data;
    });
  }

  @override
  void initState() {
    refreshJournals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Center(
            child: base64Image.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              pickImageAndConvert();
                            });
                          },
                          icon: const Icon(
                            Icons.photo_camera,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: MemoryImage(
                        base64Decode(base64Image),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Write Something';
                }
                return null;
              },
              controller: drugNameController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Drug's name",
                hintStyle: GoogleFonts.comfortaa(),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Write Something';
                      }
                      return null;
                    },
                    controller: drugDateController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Drug's date",
                      hintStyle: GoogleFonts.comfortaa(),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Write Something';
                      }
                      return null;
                    },
                    controller: drugDurationController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Drug's day",
                      hintStyle: GoogleFonts.comfortaa(),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Write Something';
                }
                return null;
              },
              controller: drugPurposeController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "What does the drug do? / headache",
                hintStyle: GoogleFonts.comfortaa(),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    addDrug();
                  });
                  refreshJournals();
                  Fluttertoast.showToast(msg: "Done", timeInSecForIosWeb: 3)
                      .then((value) => Navigator.pop(context));
                }
              },
              child: const Text(
                "Add Drug",
              ),
            ),
          )
        ],
      ),
    );
  }
}
