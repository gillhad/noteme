import 'package:flutter/material.dart';
import 'package:noteme/src/config/app_colors.dart';

ThemeData appTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
      colorScheme: ColorScheme(
          brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          primary: isDarkTheme ? AppColors.primaryDark : AppColors.primary,
          onPrimary:
              isDarkTheme ? AppColors.onPrimaryDark : AppColors.onPrimary,
          secondary:
              isDarkTheme ? AppColors.secondaryDark : AppColors.secondary,
          onSecondary: isDarkTheme
              ? AppColors.onSecondaryDark
              : AppColors.onSecondaryDark,
          error: isDarkTheme ? AppColors.errorDark : AppColors.error,
          onError: isDarkTheme ? AppColors.onErrorDark : AppColors.onError,
          background: isDarkTheme
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,
          onBackground:
              isDarkTheme ? AppColors.onBackgroundDark : AppColors.onBackground,
          surface: isDarkTheme ? AppColors.surfaceDark : AppColors.surface,
          onSurface:
              isDarkTheme ? AppColors.onSurfaceDark : AppColors.onSurface),
      scaffoldBackgroundColor:
          isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
        titleTextStyle: textTheme.headlineMedium,
      ),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 17),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          )));
}

TextTheme textTheme = const TextTheme(
  labelSmall: TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
  labelMedium: TextStyle(fontSize: 10, fontWeight: FontWeight.w500,height: 1),
  labelLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  bodySmall: TextStyle(fontSize: 9),
  bodyMedium: TextStyle(fontSize: 12, height: 1),
  bodyLarge: TextStyle(fontSize: 14),
  headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
);
