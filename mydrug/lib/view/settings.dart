import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrug/core/custom/custom_darkmode.dart';
import 'package:mydrug/core/custom/custom_delete_data.dart';
import 'package:mydrug/core/custom/custom_dvider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.bubblegumSans(
            fontSize: 22,
          ),
        ),
      ),
      body: const Column(
        children: [
          CustomDeleteData(),
          CustomDarkMode(),
          CustomDvider(),
        ],
      ),
    );
  }
}
