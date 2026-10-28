import 'package:flutter/material.dart';

/// FlowDay Design System — "Clear Current" Design Tokens
class AppColors {
  AppColors._();

  // Brand Sage Palette
  static const primary = Color(0xFF176B68);
  static const primarySage = Color(0xFF176B68);
  static const primarySageHover = Color(0xFF115B58);
  static const primarySageSubtle = Color(0xFFE5F3F1);
  static const primarySageTint = Color(0xFFF1FAF8);
  static const primaryDeep = Color(0xFF0D3D3B);
  static const primaryContainer = Color(0xFFE5F3F1);
  static const primaryGlow = Color(0x2E176B68);

  // Surfaces & Backgrounds - Light
  static const background = Color(0xFFF7FAF9);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceSecondary = Color(0xFFEDF3F1);
  static const surfaceVariant = Color(0xFFE3EDE9);

  // Dark Theme Surfaces & Backgrounds
  static const darkBackground = Color(0xFF0F1E1D);
  static const darkSurface = Color(0xFF162B29);
  static const darkSurfaceSecondary = Color(0xFF1E3836);
  static const darkSurfaceVariant = Color(0xFF264643);
  static const darkBorder = Color(0xFF2B4D49);
  static const darkBorderMedium = Color(0xFF3C6661);
  static const darkPrimarySage = Color(0xFF5CC5B6);
  static const darkPrimarySubtle = Color(0xFF1C3D3A);

  // Typography Colors - Light
  static const textPrimaryLight = Color(0xFF172B2A);
  static const textSecondaryLight = Color(0xFF5B6E6C);
  static const textMutedLight = Color(0xFF889795);
  static const textOnPrimary = Color(0xFFFFFFFF);

  // Typography Colors - Dark
  static const textPrimaryDark = Color(0xFFF0F7F5);
  static const textSecondaryDark = Color(0xFFB2C6C2);
  static const textMutedDark = Color(0xFF7E9692);

  // Backward compatible static references
  static const textPrimary = textPrimaryLight;
  static const textSecondary = textSecondaryLight;
  static const textMuted = textMutedLight;

  // Semantic Status Colors
  static const success = Color(0xFF1B8268);
  static const successLight = Color(0xFFE6F6F1);
  static const successBorder = Color(0xFFBDE9DC);

  static const warning = Color(0xFFA96717);
  static const warningLight = Color(0xFFFFF6E6);
  static const warningBorder = Color(0xFFF4D8A2);

  static const danger = Color(0xFFB84D57);
  static const dangerLight = Color(0xFFFDEDEE);
  static const dangerBorder = Color(0xFFF7C2C7);

  // Borders & Dividers
  static const border = Color(0xFFDFE9E6);
  static const borderSubtle = Color(0xFFE3ECE9);
  static const borderMedium = Color(0xFFCBD8D4);
  static const borderFocus = Color(0xFF176B68);
  static const divider = Color(0xFFDFE9E6);

  // Priority colors
  static const priorityHigh = Color(0xFFB84D57);
  static const priorityMedium = Color(0xFFA96717);
  static const priorityLow = Color(0xFF889795);

  // Category Colors
  static const catWork = Color(0xFF2B6680);
  static const catWorkBg = Color(0xFFE8F3F8);

  static const catLearning = Color(0xFF7451A3);
  static const catLearningBg = Color(0xFFF2ECFA);

  static const catPersonal = Color(0xFFA8583B);
  static const catPersonalBg = Color(0xFFFBEDE8);

  static const catHealth = Color(0xFF4C7B58);
  static const catHealthBg = Color(0xFFEAF4EA);

  static const catReading = Color(0xFF357A7B);
  static const catReadingBg = Color(0xFFE6F5F4);

  // Context-aware color helpers
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color getPrimaryText(BuildContext context) =>
      isDark(context) ? textPrimaryDark : textPrimaryLight;

  static Color getSecondaryText(BuildContext context) =>
      isDark(context) ? textSecondaryDark : textSecondaryLight;

  static Color getMutedText(BuildContext context) =>
      isDark(context) ? textMutedDark : textMutedLight;

  static Color getBorder(BuildContext context) =>
      isDark(context) ? darkBorder : borderSubtle;

  static Color getBorderMedium(BuildContext context) =>
      isDark(context) ? darkBorderMedium : borderMedium;

  static Color getCardColor(BuildContext context) =>
      isDark(context) ? darkSurface : surface;

  static Color getSurfaceSecondary(BuildContext context) =>
      isDark(context) ? darkSurfaceSecondary : surfaceSecondary;

  static Color getPrimarySubtle(BuildContext context) =>
      isDark(context) ? darkPrimarySubtle : primarySageSubtle;

  static Color getPrimaryColor(BuildContext context) =>
      isDark(context) ? darkPrimarySage : primarySage;
}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.surface,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primarySage,
    primary: AppColors.primarySage,
    primaryContainer: AppColors.primarySageSubtle,
    surface: AppColors.surface,
    surfaceContainerHighest: AppColors.surfaceSecondary,
    onPrimary: AppColors.textOnPrimary,
    onSurface: AppColors.textPrimaryLight,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textPrimaryLight,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  ),
  cardTheme: CardThemeData(
    color: AppColors.surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.borderSubtle, width: 1),
    ),
    margin: EdgeInsets.zero,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.borderMedium),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.borderSubtle),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primarySage, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.danger),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
    ),
  ),
  fontFamily: null, // Uses system font with native Arabic typography
);

final ThemeData appDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  cardColor: AppColors.darkSurface,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primarySage,
    primary: AppColors.darkPrimarySage,
    primaryContainer: AppColors.darkPrimarySubtle,
    surface: AppColors.darkSurface,
    surfaceContainerHighest: AppColors.darkSurfaceSecondary,
    onPrimary: AppColors.textPrimaryLight,
    onSurface: AppColors.textPrimaryDark,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.textPrimaryDark,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  ),
  cardTheme: CardThemeData(
    color: AppColors.darkSurface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.darkBorder, width: 1),
    ),
    margin: EdgeInsets.zero,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkBorderMedium),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkPrimarySage, width: 1.5),
    ),
  ),
  fontFamily: null,
);
