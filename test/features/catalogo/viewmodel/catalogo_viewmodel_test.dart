import 'package:flutter_test/flutter_test.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/model/servico_model.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/repository/servico_repository.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/viewmodel/catalogo_viewmodel.dart';

class _ServicoRepositoryComErro implements IServicoRepository {
  @override
  Future<List<ServicoModel>> buscarServicos() async {
    throw Exception('Falha simulada ao buscar serviços');
  }
}

void main() {
  late CatalogoViewModel viewModel;

  setUp(() {
    viewModel = CatalogoViewModel(
      const ServicoRepositoryMock(delaySimulado: Duration.zero),
    );
  });

  tearDown(() {
    viewModel.dispose();
  });

  test('inicia com estado padrão consistente antes de carregar serviços', () {
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.servicosFiltrados, isEmpty);
    expect(viewModel.categoriaSelecionada, 'Todos');
    expect(viewModel.erroMensagem, isNull);
    expect(
      viewModel.categoriasDisponiveis,
      ['Todos', 'Mobile', 'Web', 'Sistemas', 'Design', 'Consultoria'],
    );
  });

  test('carregarServicos transiciona isLoading e carrega os 5 serviços mockados', () async {
    final historicoLoading = <bool>[];
    viewModel.addListener(() {
      historicoLoading.add(viewModel.isLoading);
    });

    await viewModel.carregarServicos();

    expect(historicoLoading, [true, false]);
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.erroMensagem, isNull);
    expect(viewModel.servicosFiltrados, hasLength(5));
  });

  test('carregarServicos registra erroMensagem e limpa lista em caso de falha', () async {
    final vmComErro = CatalogoViewModel(_ServicoRepositoryComErro());
    addTearDown(vmComErro.dispose);

    await vmComErro.carregarServicos();

    expect(vmComErro.isLoading, isFalse);
    expect(vmComErro.servicosFiltrados, isEmpty);
    expect(vmComErro.erroMensagem, isNotNull);
    expect(vmComErro.erroMensagem, isNotEmpty);
  });

  test('filtrarPorCategoria filtra por categoria exata, case-insensitive e Todos', () async {
    await viewModel.carregarServicos();

    for (final categoria in [
      'Mobile',
      'Web',
      'Sistemas',
      'Design',
      'Consultoria',
    ]) {
      viewModel.filtrarPorCategoria(categoria);
      expect(viewModel.categoriaSelecionada, categoria);
      expect(viewModel.servicosFiltrados, hasLength(1));
      expect(viewModel.servicosFiltrados.first.categoria, categoria);
    }

    viewModel.filtrarPorCategoria('mobile');
    expect(viewModel.servicosFiltrados, hasLength(1));
    expect(viewModel.servicosFiltrados.first.categoria, 'Mobile');

    viewModel.filtrarPorCategoria('Todos');
    expect(viewModel.categoriaSelecionada, 'Todos');
    expect(viewModel.servicosFiltrados, hasLength(5));

    viewModel.filtrarPorCategoria('   ');
    expect(viewModel.categoriaSelecionada, 'Todos');
    expect(viewModel.servicosFiltrados, hasLength(5));
  });

  test('gerarMensagemOrcamento formata mensagem completa e trata campos vazios', () async {
    await viewModel.carregarServicos();
    final servico = viewModel.servicosFiltrados.first;

    final mensagem = viewModel.gerarMensagemOrcamento(
      servico: servico,
      nomeCliente: '  Maria Silva  ',
      descricaoIdeia: '  Quero um app para agendamento de consultas.  ',
    );

    expect(mensagem, contains('Inove Jr.'));
    expect(mensagem, contains('Maria Silva'));
    expect(mensagem, contains(servico.titulo));
    expect(mensagem, contains(servico.categoria));
    expect(mensagem, contains(servico.prazoMedio));
    expect(mensagem, contains('Quero um app para agendamento de consultas.'));

    final mensagemComVazios = viewModel.gerarMensagemOrcamento(
      servico: servico,
      nomeCliente: '   ',
      descricaoIdeia: '',
    );

    expect(mensagemComVazios, contains('Cliente'));
    expect(
      mensagemComVazios,
      contains('Gostaria de conversar sobre os detalhes do projeto.'),
    );
  });
}
