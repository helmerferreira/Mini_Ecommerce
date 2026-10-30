import 'package:dio/dio.dart';
import 'package:full_work/models/login_success_model.dart';

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
      data: {'name': name, 'email': email, 'password': password},
    );

    return response.statusCode == 201;
  }

  static Future<LoginSuccessModel?> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      "/auth/login",
      data: {"email": email, "password": password},
    );
    if (response.statusCode != 200) {
      return null;
    }
    final loginSuccessModel = LoginSuccessModel.fromJson(response.data["data"]);
    return loginSuccessModel;
  }
}
