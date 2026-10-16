import 'package:data_provider/data_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_template_app/app/app.dart';
import 'package:my_template_app/di/service_locator.dart';

class MockTokenStorage implements TokenStorage {
  String? _token;

  @override
  Future<void> saveToken(String token) async => _token = token;

  @override
  Future<String?> getToken() async => _token;

  @override
  Future<void> deleteToken() async => _token = null;
}

void main() {
  setUp(() async {
    await getIt.reset();
    getIt.registerLazySingleton<ApiClient>(() => ApiClient());
    getIt.registerLazySingleton<TokenStorage>(() => MockTokenStorage());
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        apiClient: getIt<ApiClient>(),
        tokenStorage: getIt<TokenStorage>(),
      ),
    );
  });

  testWidgets('renders LoginPage and completes login flow', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Sign In'), findsWidgets);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Enter credentials
    await tester.enterText(
      find.bySemanticsLabel('Email Address'),
      'developer@company.com',
    );
    await tester.enterText(
      find.bySemanticsLabel('Password'),
      'secret123',
    );
    await tester.pumpAndSettle();

    // Tap submit button
    await tester.tap(find.text('Sign In').last);
    await tester.pump(); // Start async login
    await tester.pumpAndSettle(); // Settle navigation

    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('developer@company.com'), findsOneWidget);
  });
}
