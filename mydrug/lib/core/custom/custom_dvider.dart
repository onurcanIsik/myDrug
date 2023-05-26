import 'package:flutter/material.dart';
import 'package:mydrug/color/colors.dart';

class CustomDvider extends StatelessWidget {
  const CustomDvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Divider(
        thickness: 2,
        endIndent: 20,
        indent: 20,
        color: drkBlue.withOpacity(0.5),
        height: 1,
      ),
    );
  }
}
