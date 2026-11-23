import 'package:flutter/material.dart';
import 'package:inovejr_portfolio_pocket/core/di/service_locator.dart';
import 'package:inovejr_portfolio_pocket/core/theme/app_theme.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/view/catalogo_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const InovePortfolioApp());
}

/// Widget raiz da aplicação "Inove Jr. - Portfólio Pocket".
class InovePortfolioApp extends StatelessWidget {
  /// Cria a instância raiz da aplicação.
  const InovePortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inove Jr. - Portfólio Pocket',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const CatalogoPage(),
    );
  }
}
