import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger_plus/talker_dio_logger_plus.dart';

/// Centralized Dio HTTP client wrapper with logging and timeouts.
class ApiClient {
  ApiClient({
    Dio? dio,
    Talker? talker,
    String? baseUrl,
  })  : _talker = talker ?? Talker(),
        _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl ?? '',
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            ) {
    _dio.interceptors.add(
      AdvancedDioLogger(
        talker: _talker,
        settings: AdvancedDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: false,
        ),
      ),
    );
  }

  final Dio _dio;
  final Talker _talker;

  Dio get dio => _dio;
  Talker get talker => _talker;
}
