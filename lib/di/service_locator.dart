import 'package:data_provider/data_provider.dart';
import 'package:get_it/get_it.dart';

/// Global service locator instance.
final getIt = GetIt.instance;

/// Sets up dependency injection for the entire application.
void setupServiceLocator() {
  // Data Layer Services
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<TokenStorage>(() => SecureTokenStorage());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiClient: getIt<ApiClient>(),
      tokenStorage: getIt<TokenStorage>(),
    ),
  );
}
