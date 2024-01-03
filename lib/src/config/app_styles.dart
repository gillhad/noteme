import 'package:flutter/material.dart';
import 'package:noteme/src/config/app_colors.dart';

ThemeData appTheme(BuildContext context,bool isDarkTheme ){
  return ThemeData(
    colorScheme: ColorScheme(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        primary: isDarkTheme ? AppColors.primaryDark : AppColors.primary,
        onPrimary: isDarkTheme ?AppColors.primaryDark : AppColors.primary,
        secondary: isDarkTheme ? AppColors.primaryDark : AppColors.primary,
        onSecondary: isDarkTheme ? AppColors.primaryDark : AppColors.primary,
        error: isDarkTheme ? AppColors.primaryDark : AppColors.primary,
        onError: isDarkTheme ? AppColors.primaryDark : AppColors.primary,
        background:  isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
        onBackground: isDarkTheme ? AppColors.primaryDark : AppColors.primary,
        surface: isDarkTheme ? AppColors.primaryDark : AppColors.primary,
        onSurface: isDarkTheme ?AppColors.primaryDark : AppColors.primary),
    scaffoldBackgroundColor: isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
  appBarTheme: AppBarTheme(
      backgroundColor: isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
    titleTextStyle: textTheme.headlineMedium,
  )
  );
}

 TextTheme textTheme =  TextTheme(
  labelSmall: TextStyle(),
  labelMedium: TextStyle(),
  labelLarge: TextStyle(),
  bodySmall: TextStyle(),
  bodyMedium: TextStyle(),
  bodyLarge: TextStyle(),
  headlineSmall: TextStyle(),
    headlineMedium: TextStyle(fontSize: 18),
  headlineLarge: TextStyle(),
);