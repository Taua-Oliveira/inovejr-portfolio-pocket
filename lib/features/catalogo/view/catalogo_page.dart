import 'package:flutter/material.dart';

// TODO: Tela a ser implementada pela equipe de UI
// Dica de integração com a ViewModel:
// 1. Converta para StatefulWidget ou obtenha a ViewModel via `getIt<CatalogoViewModel>()`.
// 2. No `initState`, chame `_viewModel.carregarServicos()` e lembre-se de chamar `_viewModel.dispose()` no `dispose()`.
// 3. No `build`, envolva a interface com `ListenableBuilder(listenable: _viewModel, builder: ...)`
//    para reagir a `isLoading`, `erroMensagem`, `categoriaSelecionada` e `servicosFiltrados`.

/// Tela principal do catálogo de serviços da Inove Jr.
class CatalogoPage extends StatelessWidget {
  /// Cria a tela inicial do catálogo.
  const CatalogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inove Jr. - Portfólio Pocket'),
      ),
      body: const Center(
        child: Text('Catálogo de Serviços (em desenvolvimento)'),
      ),
    );
  }
}
