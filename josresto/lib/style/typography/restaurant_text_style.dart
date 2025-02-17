import 'package:flutter/material.dart';

class RestaurantTextStyle {
  static const TextStyle _commonStyle = TextStyle(
    fontFamily: 'Ubuntu',
  );

  /// displayLarge Text Style
  static TextStyle displayLarge = _commonStyle.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    height: 1.11,
    letterSpacing: -2,
  );

  /// displaySmall Text Style
  static TextStyle displaySmall = _commonStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: -1,
  );

  /// headlineMedium Text Style
  static TextStyle headlineMedium = _commonStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: -1,
  );

  /// headlineMedium Text Style
  static TextStyle headlineSmall = _commonStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: -1,
  );

  /// titleLarge Text Style
  static TextStyle titleLarge = _commonStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 1.2,
  );

  /// titleMedium Text Style
  static TextStyle titleMedium = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 1.2,
  );

  /// titleSmall Text Style
  static TextStyle titleSmall = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: 1.2,
  );

  /// bodyLargeBold Text Style
  static TextStyle bodyLargeBold = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.56,
  );

  /// bodyLargeMedium Text Style
  static TextStyle bodyLargeMedium = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.56,
  );

  /// labelLarge Text Style
  static TextStyle labelLarge = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.71,
    letterSpacing: 1.3,
  );
}
