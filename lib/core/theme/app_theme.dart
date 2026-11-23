import 'package:flutter/material.dart';

/// Tema corporativo da Inove Jr. baseado em Material 3.
///
/// Centraliza a paleta de cores oficial (azul-marinho e azul ciano elétrico)
/// e os estilos globais de componentes para garantir consistência visual entre telas.
class AppTheme {
  AppTheme._();

  /// Azul-marinho escuro utilizado como cor primária institucional.
  static const Color primaryNavy = Color(0xFF0A1F44);

  /// Azul corporativo intermediário para variações sutis e bordas.
  static const Color primaryLight = Color(0xFF1A3A73);

  /// Azul ciano elétrico usado para destaques, CTAs e elementos interativos.
  static const Color accentCyan = Color(0xFF00B4D8);

  /// Tom suave de ciano para realces secundários e superfícies de apoio.
  static const Color accentCyanLight = Color(0xFF90E0EF);

  /// Fundo claro padrão das telas.
  static const Color backgroundLight = Color(0xFFF5F7FA);

  /// Branco puro para cartões, campos e superfícies elevadas.
  static const Color surfaceWhite = Color(0xFFFFFFFF);

  /// Cor principal de texto de alto contraste.
  static const Color textPrimary = Color(0xFF0F172A);

  /// Cor secundária para subtítulos e descrições de apoio.
  static const Color textSecondary = Color(0xFF475569);

  /// Configuração padrão do tema claro da aplicação.
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryNavy,
      brightness: Brightness.light,
    ).copyWith(
      primary: primaryNavy,
      onPrimary: Colors.white,
      secondary: accentCyan,
      onSecondary: primaryNavy,
      surface: surfaceWhite,
      onSurface: textPrimary,
      surfaceContainerLowest: surfaceWhite,
      surfaceContainerLow: backgroundLight,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceWhite,
        selectedColor: primaryNavy,
        secondarySelectedColor: primaryNavy,
        disabledColor: backgroundLight,
        labelStyle: const TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        checkmarkColor: accentCyan,
        side: BorderSide(color: primaryLight.withValues(alpha: 0.25)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryNavy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accentCyan,
          foregroundColor: primaryNavy,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryLight.withValues(alpha: 0.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryLight.withValues(alpha: 0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentCyan, width: 2),
        ),
      ),
    );
  }
}
