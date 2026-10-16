import '../api/api_client.dart';
import '../models/user_model.dart';
import '../storage/token_storage.dart';

/// Authentication repository interface following Clean Architecture.
abstract interface class AuthRepository {
  Future<UserModel> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<UserModel?> getCurrentUser();
}

/// Production implementation of [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required ApiClient apiClient,
    required TokenStorage tokenStorage,
  })  : _apiClient = apiClient,
        _tokenStorage = tokenStorage;

  // ignore: unused_field
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  UserModel? _cachedUser;

  @override
  Future<UserModel> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // In production, delegate to _apiClient.dio.post('/auth/login', ...)
    // For template demonstration:
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final user = UserModel(
      id: 'usr_01',
      email: email,
      name: email.split('@').first,
    );
    _cachedUser = user;
    await _tokenStorage.saveToken('jwt_token_sample');
    return user;
  }

  @override
  Future<void> logOut() async {
    _cachedUser = null;
    await _tokenStorage.deleteToken();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final token = await _tokenStorage.getToken();
    if (token == null) return null;
    return _cachedUser;
  }
}
