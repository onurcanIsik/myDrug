import 'package:flutter/material.dart';

Widget ovalLogoWidget(String imagePath) {
  return ClipOval(
    child: Image.asset(
      imagePath,
      fit: BoxFit.cover,
    ),
  );
}
