import 'package:dio/dio.dart';
import 'package:full_work/core/erros/app_error.dart';
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

  static Future<LoginSuccessModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        "/auth/login",
        data: {"email": email, "password": password},
      );
      if (response.statusCode != 200) {
        throw AppError();
      }
      final loginSuccessModel = LoginSuccessModel.fromJson(
        response.data["data"],
      );
      return loginSuccessModel;
    } catch (e) {
      if (e is! DioException) {
        throw AppError();
      }
      final resposta = e.response?.data as Map;
      if (e.response?.statusCode == 400 && resposta.containsKey("error")) {
        final List detalhes = (resposta["error"]["details"]) ?? [];
        if (detalhes.isEmpty) {
          throw AppError();
        }
        throw AppError(
          detalhes.first["message"] ?? "Ocorreu um erro, tente novamente",
        );
      }
      if (e.response?.statusCode == 401 && resposta.containsKey("error")) {
        throw AppError(
          resposta["error"]["message"] ?? "Ocorreu um erro, tente novamente",
        );
      }

      return throw AppError();
    }
  }
}
