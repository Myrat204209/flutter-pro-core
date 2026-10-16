import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'di/service_locator.dart';

/// Custom [BlocObserver] that observes bloc state transitions and errors.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    debugPrint('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

/// Initializes fundamental services, state observers, and launches the application.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  setupServiceLocator();

  runApp(await builder());
}
