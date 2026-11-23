import 'package:get_it/get_it.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/repository/servico_repository.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/viewmodel/catalogo_viewmodel.dart';

/// Instância global do container de injeção de dependências (`GetIt`).
///
/// Deve ser usada apenas para resolver dependências já registradas em [setupServiceLocator].
final GetIt getIt = GetIt.instance;

/// Configura todas as dependências da aplicação antes do `runApp`.
///
/// - `registerLazySingleton`: cria uma única instância compartilhada sob demanda
///   (ideal para repositórios e serviços sem estado de tela).
/// - `registerFactory`: cria uma nova instância a cada chamada de `getIt<...>()`
///   (ideal para ViewModels vinculadas ao ciclo de vida de uma tela).
void setupServiceLocator() {
  if (!getIt.isRegistered<IServicoRepository>()) {
    getIt.registerLazySingleton<IServicoRepository>(
      () => const ServicoRepositoryMock(),
    );
  }

  if (!getIt.isRegistered<CatalogoViewModel>()) {
    getIt.registerFactory<CatalogoViewModel>(
      () => CatalogoViewModel(getIt<IServicoRepository>()),
    );
  }
}
