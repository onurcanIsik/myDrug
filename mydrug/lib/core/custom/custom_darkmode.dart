import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrug/core/custom/custom_switch.dart';

import '../../color/colors.dart';

class CustomDarkMode extends StatefulWidget {
  const CustomDarkMode({super.key});

  @override
  State<CustomDarkMode> createState() => _CustomDarkModeState();
}

class _CustomDarkModeState extends State<CustomDarkMode> {
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
                  "Dark Mode",
                  style: GoogleFonts.comfortaa(
                    fontWeight: FontWeight.bold,
                    color: ligBlue,
                    fontSize: 16,
                  ),
                ),
                const CustomSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
