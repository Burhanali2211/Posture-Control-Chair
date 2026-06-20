import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

abstract final class AppTheme {
  static const _radius = Radius.circular(20);
  static const _shape  = RoundedRectangleBorder(borderRadius: BorderRadius.all(_radius));

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor:       AppColors.primary,
          primary:         AppColors.primary,
          secondary:       AppColors.secondary,
          surface:         AppColors.surface,
          brightness:      Brightness.light,
        ).copyWith(surface: AppColors.surface),
        scaffoldBackgroundColor: AppColors.background,
        cardTheme: const CardThemeData(
          color:     AppColors.surface,
          elevation: 0,
          shape:     _shape,
          margin:    EdgeInsets.zero,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape:   _shape,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.text),
          titleMedium:    TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.text),
          bodyMedium:     TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.text),
          bodySmall:      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textMuted),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor:  AppColors.background,
          surfaceTintColor: Colors.transparent,
          elevation:        0,
          centerTitle:      false,
          titleTextStyle:   TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.text),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor:        AppColors.surface,
          indicatorColor:         AppColors.primary.withAlpha(26),
          labelTextStyle:         WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor:  AppColors.primary,
          primary:    AppColors.primary,
          secondary:  AppColors.secondary,
          brightness: Brightness.dark,
        ),
        cardTheme: const CardThemeData(elevation: 0, shape: _shape, margin: EdgeInsets.zero),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape:   _shape,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      );
}
