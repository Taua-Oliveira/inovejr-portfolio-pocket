import 'package:flutter/foundation.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/model/servico_model.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/repository/servico_repository.dart';

/// ViewModel responsável por toda a lógica de apresentação do catálogo de serviços.
///
/// Como esta classe estende [ChangeNotifier], a View não precisa guardar estado de
/// negócio com `setState`. Basta obter a instância via `getIt<CatalogoViewModel>()`
/// e envolver a árvore de widgets com `ListenableBuilder`:
///
/// ```dart
/// ListenableBuilder(
///   listenable: viewModel,
///   builder: (context, _) {
///     if (viewModel.isLoading) return const CircularProgressIndicator();
///     if (viewModel.erroMensagem != null) return Text(viewModel.erroMensagem!);
///     return ListView.builder(...); // usa viewModel.servicosFiltrados
///   },
/// )
/// ```
class CatalogoViewModel extends ChangeNotifier {
  /// Recebe a abstração [IServicoRepository] por injeção de dependência,
  /// mantendo a ViewModel desacoplada da fonte concreta de dados e fácil de testar.
  CatalogoViewModel(this._repository);

  final IServicoRepository _repository;

  /// Rótulo padrão que representa todos os serviços sem filtro de categoria.
  static const String categoriaTodos = 'Todos';

  /// Lista padrão de categorias exibida enquanto os serviços ainda não foram carregados.
  static const List<String> categoriasPadrao = [
    'Todos',
    'Mobile',
    'Web',
    'Sistemas',
    'Design',
    'Consultoria',
  ];

  // ---------------------------------------------------------------------------
  // Estado interno privado (apenas a própria ViewModel pode alterar esses valores)
  // ---------------------------------------------------------------------------

  bool _isLoading = false;
  List<ServicoModel> _todosServicos = const [];
  List<ServicoModel> _servicosFiltrados = const [];
  String _categoriaSelecionada = categoriaTodos;
  String? _erroMensagem;

  // ---------------------------------------------------------------------------
  // Getters públicos expostos para a View ler dentro do ListenableBuilder
  // ---------------------------------------------------------------------------

  /// Indica se uma busca de serviços está em andamento para exibir indicador de carga.
  bool get isLoading => _isLoading;

  /// Lista de serviços já filtrada de acordo com [categoriaSelecionada].
  ///
  /// Retorna uma lista imutável para impedir que a View altere o estado diretamente.
  List<ServicoModel> get servicosFiltrados =>
      List.unmodifiable(_servicosFiltrados);

  /// Categoria atualmente selecionada nos chips de filtro (inicia em `"Todos"`).
  String get categoriaSelecionada => _categoriaSelecionada;

  /// Mensagem amigável de erro caso o carregamento falhe, ou `null` quando não há erro.
  String? get erroMensagem => _erroMensagem;

  /// Categorias disponíveis para montar os botões/chips de filtro na interface.
  ///
  /// Quando os serviços já foram carregados, extrai as categorias existentes
  /// sem duplicatas; caso contrário, utiliza [categoriasPadrao].
  List<String> get categoriasDisponiveis {
    if (_todosServicos.isEmpty) {
      return categoriasPadrao;
    }

    return List.unmodifiable([
      categoriaTodos,
      ...{for (final servico in _todosServicos) servico.categoria},
    ]);
  }

  // ---------------------------------------------------------------------------
  // Ações e regras de negócio chamadas pela View
  // ---------------------------------------------------------------------------

  /// Busca os serviços no repositório e atualiza a lista exibida pela tela.
  ///
  /// Fluxo de estados:
  /// 1. Ativa `isLoading`, limpa qualquer erro anterior e notifica a View.
  /// 2. Busca os dados no repositório e reaplica o filtro da categoria atual.
  /// 3. Em caso de falha, limpa as listas e registra uma mensagem amigável em `erroMensagem`.
  /// 4. No bloco `finally`, desativa `isLoading` e notifica a View novamente.
  Future<void> carregarServicos() async {
    _isLoading = true;
    _erroMensagem = null;
    notifyListeners();

    try {
      final servicos = await _repository.buscarServicos();
      _todosServicos = List.unmodifiable(servicos);
      _aplicarFiltro();
    } catch (_) {
      _todosServicos = const [];
      _servicosFiltrados = const [];
      _erroMensagem =
          'Não foi possível carregar os serviços no momento. Tente novamente.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Atualiza a categoria ativa e recalcula [servicosFiltrados].
  ///
  /// Aceita valores como `"Todos"`, `"Mobile"`, `"Web"`, `"Sistemas"`, `"Design"`
  /// ou `"Consultoria"`. Caso receba uma string vazia ou apenas espaços, volta para
  /// `"Todos"` e notifica a interface imediatamente.
  void filtrarPorCategoria(String categoria) {
    final categoriaNormalizada = categoria.trim();
    _categoriaSelecionada =
        categoriaNormalizada.isEmpty ? categoriaTodos : categoriaNormalizada;

    _aplicarFiltro();
    notifyListeners();
  }

  /// Regra interna de filtragem que mantém `_todosServicos` preservado em memória.
  ///
  /// Assim, trocar de filtro não exige fazer uma nova consulta ao repositório.
  void _aplicarFiltro() {
    if (_categoriaSelecionada.toLowerCase() == categoriaTodos.toLowerCase()) {
      _servicosFiltrados = _todosServicos;
      return;
    }

    _servicosFiltrados = _todosServicos
        .where(
          (servico) =>
              servico.categoria.toLowerCase() ==
              _categoriaSelecionada.toLowerCase(),
        )
        .toList(growable: false);
  }

  /// Monta a mensagem formatada e profissional pronta para envio via WhatsApp.
  ///
  /// O texto gerado inclui saudação à equipe da Inove Jr., nome do cliente,
  /// serviço de interesse, categoria, prazo médio estimado e o resumo da ideia.
  /// A View pode passar o retorno deste método para o `url_launcher` abrir o WhatsApp.
  String gerarMensagemOrcamento({
    required ServicoModel servico,
    required String nomeCliente,
    required String descricaoIdeia,
  }) {
    // Garante valores padrão legíveis caso o usuário deixe algum campo em branco.
    final nomeFormatado =
        nomeCliente.trim().isEmpty ? 'Cliente' : nomeCliente.trim();
    final ideiaFormatada = descricaoIdeia.trim().isEmpty
        ? 'Gostaria de conversar sobre os detalhes do projeto.'
        : descricaoIdeia.trim();

    return 'Olá, equipe da Inove Jr.! Tudo bem?\n\n'
        'Meu nome é $nomeFormatado e gostaria de solicitar um orçamento para o serviço abaixo:\n'
        '• Serviço: ${servico.titulo}\n'
        '• Categoria: ${servico.categoria}\n'
        '• Prazo médio estimado: ${servico.prazoMedio}\n\n'
        'Resumo da minha ideia:\n'
        '$ideiaFormatada\n\n'
        'Aguardo retorno para conversarmos sobre os próximos passos!';
  }
}
