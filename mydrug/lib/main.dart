import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydrug/color/colors.dart';
import 'package:mydrug/core/theme/theme_provider.dart';
import 'package:mydrug/view/home/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.isDarkTheme
                ? _buildDarkTheme()
                : _buildLightTheme(),
            debugShowCheckedModeBanner: false,
            home: const MyApp(),
          );
        },
      ),
    ),
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: drkBlue,
      shadowColor: ligBlue,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: drkBlue,
      foregroundColor: ligBlue,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(drkBlue),
        foregroundColor: MaterialStateProperty.all<Color>(ligBlue),
        textStyle: MaterialStateProperty.all<TextStyle>(
          GoogleFonts.comfortaa(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

ThemeData _buildLightTheme() {
  return ThemeData.light(useMaterial3: true).copyWith(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ligBlue,
      foregroundColor: drkBlue,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(ligBlue),
        foregroundColor: MaterialStateProperty.all<Color>(drkBlue),
        textStyle: MaterialStateProperty.all<TextStyle>(
          GoogleFonts.comfortaa(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    scaffoldBackgroundColor: bgColor,
    appBarTheme: AppBarTheme(
      shadowColor: drkBlue,
      iconTheme: IconThemeData(color: drkBlue),
      backgroundColor: ligBlue,
      titleTextStyle: TextStyle(color: drkBlue),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("assets/images/mydrug_nobg.png"),
      title: Text(
        "MyDrug",
        style: GoogleFonts.bubblegumSans(
          fontSize: 22,
          color: drkBlue,
        ),
      ),
      backgroundColor: bgColor,
      showLoader: true,
      loaderColor: depPurp,
      loadingText: Text(
        "Loading...",
        style: GoogleFonts.comfortaa(),
      ),
      navigator: const HomePage(),
      durationInSeconds: 5,
    );
  }
}
