import 'package:flutter/material.dart';
import 'app_colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,  // Keep white for light mode
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.gradientStart,  // Apply gradient start for AppBar
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: AppColors.gradientEnd,  // Apply gradient end for dark mode
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.gradientEnd,  // Dark gradient for AppBar
  ),
);
