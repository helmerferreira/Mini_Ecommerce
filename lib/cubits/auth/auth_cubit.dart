import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_work/cubits/auth/auth_state.dart';
import 'package:full_work/services/api_services.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  Future<bool> login({required String email, required String password}) async {
    emit(AuthLoadingState());
    final data = await ApiServices.login(email: email, password: password);
    if (data == null || data.user == null) {
      emit(AuthErrorState("Erro!!!!"));
      return false;
    }
    emit(AuthAuthenticatedState(data.user!));
    return true;
  }
}
