import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF2563EB);
  static const primaryDark = Color(0xFF1E3A8A);
  static const primarySoft = Color(0xFFEFF4FF);
  static const background = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE2E8F0);
  static const text = Color(0xFF0F172A);
  static const secondary = Color(0xFF64748B);
  static const accent = Color(0xFFF59E0B);
  static const success = Color(0xFF10B981);
  static const danger = Color(0xFFDC2626);
  static const warningBg = Color(0xFFFFFBEB);
  static const warningText = Color(0xFFB45309);
}

class AppText {
  AppText._();

  /// Poppins SemiBold — judul.
  static TextStyle heading(
    double size, {
    Color color = AppColors.text,
    double height = 1.2,
  }) =>
      TextStyle(
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: color,
        height: height,
      );

  /// Inter Regular/Bold — teks biasa.
  static TextStyle body(
    double size, {
    Color color = AppColors.text,
    FontWeight weight = FontWeight.w400,
    double height = 1.4,
  }) =>
      TextStyle(
        fontFamily: 'Inter',
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );

  /// Inter SemiBold — label.
  static TextStyle label(
    double size, {
    Color color = AppColors.text,
  }) =>
      TextStyle(
        fontFamily: 'Inter',
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle caption(double size, {Color color = AppColors.secondary}) =>
      body(size, color: color);
}
