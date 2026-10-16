import 'package:data_provider/data_provider.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeTokenStorage implements TokenStorage {
  String? _token;

  @override
  Future<void> saveToken(String token) async => _token = token;

  @override
  Future<String?> getToken() async => _token;

  @override
  Future<void> deleteToken() async => _token = null;
}

void main() {
  group('UserModel', () {
    test('supports value equality via Equatable', () {
      const user1 = UserModel(id: '1', email: 'test@example.com', name: 'Test');
      const user2 = UserModel(id: '1', email: 'test@example.com', name: 'Test');
      expect(user1, equals(user2));
    });

    test('serializes to and from JSON correctly', () {
      const user = UserModel(id: '10', email: 'dev@test.com', name: 'Developer');
      final json = user.toJson();
      final parsed = UserModel.fromJson(json);
      expect(parsed, equals(user));
    });
  });

  group('AuthRepositoryImpl', () {
    late FakeTokenStorage tokenStorage;
    late AuthRepository authRepository;

    setUp(() {
      tokenStorage = FakeTokenStorage();
      authRepository = AuthRepositoryImpl(
        apiClient: ApiClient(),
        tokenStorage: tokenStorage,
      );
    });

    test('logInWithEmailAndPassword stores token and returns user', () async {
      final user = await authRepository.logInWithEmailAndPassword(
        email: 'alice@example.com',
        password: 'password123',
      );

      expect(user.email, 'alice@example.com');
      expect(await tokenStorage.getToken(), isNotNull);

      final current = await authRepository.getCurrentUser();
      expect(current, equals(user));
    });

    test('logOut clears token and user cache', () async {
      await authRepository.logInWithEmailAndPassword(
        email: 'alice@example.com',
        password: 'password123',
      );
      await authRepository.logOut();

      expect(await tokenStorage.getToken(), isNull);
      expect(await authRepository.getCurrentUser(), isNull);
    });
  });
}
