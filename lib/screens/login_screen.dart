import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_work/cubits/auth/auth_cubit.dart';
import 'package:full_work/cubits/auth/auth_state.dart';

import 'registrar_1.dart';
import 'widget_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthCubit authCubit;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    authCubit = AuthCubit();
    super.initState();
  }

  @override
  void dispose() {
    authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Customtextfild(
                  hintText: "Email",
                  prefixIcon: Icons.email_rounded,
                  controller: _emailController,
                ),
                SizedBox(height: 10),
                Customtextfild(
                  hintText: "Senha",
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  controller: _passwordController,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: BlocBuilder(
                    bloc: authCubit,
                    builder: (context, AuthState state) {
                      if (state is AuthLoadingState) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is AuthAuthenticatedState) {
                        return Text(state.user.name ?? "Nome não fornecido");
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          final password = _passwordController.text;
                          final email = _emailController.text.trim();
                          final hasBeenSuccess = await authCubit.login(
                            email: email,
                            password: password,
                          );
                          if (hasBeenSuccess) {
                            print("Login FEITO COM SUCESSO");
                          } else {
                            print("Login mal feito");
                          }
                        },
                        child: Text("Entrar"),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),

                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Registrar1(),
                        ),
                      );
                    },
                    child: Text("Registrar"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
