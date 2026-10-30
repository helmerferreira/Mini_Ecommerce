import 'package:full_work/models/user_model.dart';

class LoginSuccessModel {
  final UserModel? user;
  final String? token;

  LoginSuccessModel({this.user, this.token});

  static LoginSuccessModel fromJson(Map<String, dynamic> json) {
    return LoginSuccessModel(
      user: json["user"],
      token: json["token"]
    );
  }
}
