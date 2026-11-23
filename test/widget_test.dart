import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inovejr_portfolio_pocket/core/di/service_locator.dart';
import 'package:inovejr_portfolio_pocket/core/theme/app_theme.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/repository/servico_repository.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/view/catalogo_page.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/viewmodel/catalogo_viewmodel.dart';
import 'package:inovejr_portfolio_pocket/main.dart';

void main() {
  setUp(() {
    setupServiceLocator();
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets(
    'InovePortfolioApp renderiza CatalogoPage com tema corporativo Material 3',
    (WidgetTester tester) async {
      await tester.pumpWidget(const InovePortfolioApp());

      expect(find.byType(CatalogoPage), findsOneWidget);
      expect(find.text('Inove Jr. - Portfólio Pocket'), findsOneWidget);

      final context = tester.element(find.byType(CatalogoPage));
      final theme = Theme.of(context);

      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.primary, AppTheme.primaryNavy);
      expect(theme.colorScheme.secondary, AppTheme.accentCyan);
    },
  );

  test(
    'setupServiceLocator registra IServicoRepository como LazySingleton e CatalogoViewModel como Factory',
    () {
      final repo1 = getIt<IServicoRepository>();
      final repo2 = getIt<IServicoRepository>();

      expect(identical(repo1, repo2), isTrue);

      final vm1 = getIt<CatalogoViewModel>();
      final vm2 = getIt<CatalogoViewModel>();
      addTearDown(() {
        vm1.dispose();
        vm2.dispose();
      });

      expect(identical(vm1, vm2), isFalse);
    },
  );
}
