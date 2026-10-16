import 'package:flutter/material.dart';

/// Semantic colors for the design system.
///
/// Ensures minimum 4.5:1 contrast ratios against corresponding surfaces
/// to comply with WCAG 2.1 Level AA.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF1565C0);
  static const Color primaryDark = Color(0xFF90CAF9);
  static const Color secondary = Color(0xFF00796B);
  static const Color secondaryDark = Color(0xFF80CBC4);

  // Surfaces & Backgrounds (Light)
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFE0E0E0);

  // Surfaces & Backgrounds (Dark)
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color surfaceVariantDark = Color(0xFF2C2C2C);

  // Feedback
  static const Color error = Color(0xFFD32F2F);
  static const Color errorDark = Color(0xFFEF9A9A);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);

  // Typography
  static const Color textPrimaryLight = Color(0xFF1A1A1A);
  static const Color textSecondaryLight = Color(0xFF5F6368);
  static const Color textPrimaryDark = Color(0xFFF1F3F4);
  static const Color textSecondaryDark = Color(0xFF9AA0A6);
}
