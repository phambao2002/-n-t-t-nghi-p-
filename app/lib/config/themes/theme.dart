import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFFE3E5E8),
      fontFamily: 'Poppins',
      secondaryHeaderColor: Color(0xFF707B89),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      appBarTheme: AppBarTheme(backgroundColor: Color(0xFF35a163)),
      splashColor: Color(0xFFE8EAED),
      backgroundColor: Color(0xFFFFFFFF),
      colorScheme: ColorScheme(
              primary: Color(0xFF35a163),
              secondary: Color(0xFFF2F3F5),
              surface: Colors.white,
              background: Color(0xFFE3E5E8),
              error: Color(0xFFE93E36),
              onPrimary: Colors.white,
              onSecondary: Color(0xFF737E8C),
              onSurface: Colors.black,
              onBackground: Color(0xFF2E3338),
              onError: Color(0xFFE3E5E8),
              brightness: Brightness.light)
          .copyWith(secondary: Color(0xFF35a163)));
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFF202225),
      fontFamily: 'Poppins',
      secondaryHeaderColor: Color(0xFF6D7177),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      appBarTheme: AppBarTheme(backgroundColor: Color(0xFF35a163)),
      splashColor: Color(0xFF34373C),
      backgroundColor: Color(0xFF36393F),
      colorScheme: ColorScheme(
              primary: Color(0xFF35a163),
              secondary: Color(0xFF2F3136),
              surface: Color(4279374354),
              background: Color(0xFF202225),
              error: Color(0xFFED4337),
              onPrimary: Colors.white,
              onSecondary: Color(0xFF72767D),
              onSurface: Colors.white,
              onBackground: Color(0xFFF8F5F9),
              onError: Color(0xFF202225),
              brightness: Brightness.dark)
          .copyWith(secondary: Color(0xFF35a163)));
}
