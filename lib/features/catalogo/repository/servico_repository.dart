import 'package:inovejr_portfolio_pocket/features/catalogo/model/servico_model.dart';

/// Contrato abstrato da camada de dados para consulta aos serviços do portfólio.
///
/// Usar uma interface permite trocar facilmente a origem dos dados (mock local,
/// API REST, Firebase, etc.) sem alterar a ViewModel ou as telas.
abstract class IServicoRepository {
  /// Retorna a lista de serviços disponíveis no portfólio da Inove Jr.
  Future<List<ServicoModel>> buscarServicos();
}

/// Implementação mockada de [IServicoRepository] para desenvolvimento inicial.
///
/// Simula uma requisição assíncrona com atraso configurável e retorna
/// 5 serviços realistas oferecidos pela Inove Jr.
class ServicoRepositoryMock implements IServicoRepository {
  /// Cria o repositório mock com atraso opcional para simular latência de rede.
  const ServicoRepositoryMock({
    this.delaySimulado = const Duration(milliseconds: 500),
  });

  /// Tempo de espera simulado antes de retornar a lista de serviços.
  final Duration delaySimulado;

  static const List<ServicoModel> _servicosMock = [
    ServicoModel(
      id: '1',
      titulo: 'Desenvolvimento de Aplicativos Mobile',
      categoria: 'Mobile',
      descricaoCurta:
          'Apps multiplataforma em Flutter para Android e iOS com foco em usabilidade.',
      descricaoCompleta:
          'Desenvolvemos aplicativos completos e escaláveis utilizando Flutter, '
          'garantindo desempenho nativo em Android e iOS a partir de uma única base '
          'de código. O projeto inclui levantamento de requisitos, prototipação e '
          'integração com APIs ou bancos de dados em nuvem.',
      prazoMedio: '6 a 10 semanas',
      entregaveis: [
        'Prototipação UI/UX',
        'Código-fonte Flutter (Android e iOS)',
        'Publicação nas lojas',
      ],
      iconeNome: 'smartphone',
    ),
    ServicoModel(
      id: '2',
      titulo: 'Criação de Sites Institucionais',
      categoria: 'Web',
      descricaoCurta:
          'Sites modernos, responsivos e otimizados para fortalecer a presença digital.',
      descricaoCompleta:
          'Construímos sites institucionais e landing pages de alta conversão, '
          'adaptados para computadores, tablets e smartphones. Priorizamos velocidade '
          'de carregamento, identidade visual alinhada à marca e boas práticas de SEO.',
      prazoMedio: '3 a 5 semanas',
      entregaveis: [
        'Design responsivo',
        'Otimização básica de SEO',
        'Deploy e configuração de domínio',
      ],
      iconeNome: 'language',
    ),
    ServicoModel(
      id: '3',
      titulo: 'Sistemas Web Sob Medida',
      categoria: 'Sistemas',
      descricaoCurta:
          'Plataformas personalizadas para automatizar processos e centralizar dados.',
      descricaoCompleta:
          'Projetamos sistemas web sob medida para resolver gargalos operacionais '
          'de empresas e negócios locais, incluindo controle de acesso, painéis '
          'gerenciais, relatórios e integrações seguras com serviços externos.',
      prazoMedio: '8 a 12 semanas',
      entregaveis: [
        'Levantamento de requisitos',
        'Painel administrativo e API',
        'Documentação e treinamento',
      ],
      iconeNome: 'computer',
    ),
    ServicoModel(
      id: '4',
      titulo: 'Prototipação UI/UX',
      categoria: 'Design',
      descricaoCurta:
          'Protótipos navegáveis e estudo de experiência do usuário antes do código.',
      descricaoCompleta:
          'Mapeamos a jornada dos usuários e criamos protótipos interativos de alta '
          'fidelidade no Figma para validar ideias, reduzir retrabalho no '
          'desenvolvimento e garantir interfaces intuitivas e acessíveis.',
      prazoMedio: '2 a 4 semanas',
      entregaveis: [
        'Wireframes de fluxo',
        'Protótipo navegável no Figma',
        'Guia de estilos e componentes',
      ],
      iconeNome: 'design_services',
    ),
    ServicoModel(
      id: '5',
      titulo: 'Consultoria Tecnológica',
      categoria: 'Consultoria',
      descricaoCurta:
          'Diagnóstico digital e recomendações estratégicas para escolher a melhor solução.',
      descricaoCompleta:
          'Apoiamos empreendedores e empresas na escolha de tecnologias, arquitetura '
          'de sistemas, melhoria de processos digitais e definição de roadmap técnico '
          'para tirar novos produtos do papel com segurança.',
      prazoMedio: '1 a 3 semanas',
      entregaveis: [
        'Diagnóstico técnico',
        'Mapeamento de soluções e ferramentas',
        'Plano de ação priorizado',
      ],
      iconeNome: 'lightbulb',
    ),
  ];

  @override
  Future<List<ServicoModel>> buscarServicos() async {
    if (delaySimulado > Duration.zero) {
      await Future<void>.delayed(delaySimulado);
    }
    return List<ServicoModel>.unmodifiable(_servicosMock);
  }
}
