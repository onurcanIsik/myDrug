import 'package:flutter/material.dart';
import 'package:mydrug/color/colors.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSwitched = false;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.check);
    }
    return const Icon(Icons.close);
  });
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch(
      activeColor: Colors.greenAccent,
      inactiveTrackColor: ligBlue,
      inactiveThumbColor: drkBlue,
      thumbIcon: thumbIcon,
      value: themeProvider.isDarkTheme,
      onChanged: (value) {
        setState(() {
          themeProvider.toggleTheme(value);
        });
      },
    );
  }
}
