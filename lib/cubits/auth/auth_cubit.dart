import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_work/core/erros/app_error.dart';
import 'package:full_work/cubits/auth/auth_state.dart';
import 'package:full_work/services/api_services.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  Future<bool> login({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      final data = await ApiServices.login(email: email, password: password);
      emit(AuthAuthenticatedState(data.user!));
      return true;
    } catch (e) {
      if (e is AppError) {
        emit(AuthErrorState(e.error));
        return false;
      }
      emit(AuthErrorState(AppError().error));
      return false;
    }
  }
}
