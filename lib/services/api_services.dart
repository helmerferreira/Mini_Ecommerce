import 'package:dio/dio.dart';

class ApiServices {
  static const String baseUrl = 'https://backend-helmer.onrender.com/api/v1';
  static const Duration requestTimeout = Duration(seconds: 90);
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: requestTimeout,
      receiveTimeout: requestTimeout,
      sendTimeout: requestTimeout,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static Future<bool> registrar({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return response.statusCode == 201;
  }
}
