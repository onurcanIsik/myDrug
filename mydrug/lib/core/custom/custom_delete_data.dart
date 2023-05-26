import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrug/core/database/drug_database.dart';

import '../../color/colors.dart';

class CustomDeleteData extends StatefulWidget {
  const CustomDeleteData({super.key});

  @override
  State<CustomDeleteData> createState() => _CustomDeleteDataState();
}

class _CustomDeleteDataState extends State<CustomDeleteData> {
  Future<void> deleteAllDrug() async {
    await DrugSql.deleteAllDrugs();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: drkBlue,
          color: drkBlue,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Delete All Data",
                  style: GoogleFonts.comfortaa(
                    fontWeight: FontWeight.bold,
                    color: ligBlue,
                    fontSize: 16,
                  ),
                ),
                IconButton.outlined(
                  onPressed: () {
                    setState(() {
                      deleteAllDrug().then(
                        (value) => Fluttertoast.showToast(
                          msg: "All Data Deleted!",
                          timeInSecForIosWeb: 3,
                        ),
                      );
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: ligBlue,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
