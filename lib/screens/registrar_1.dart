import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:full_work/services/api_services.dart';

import 'widget_login.dart';

class Registrar1 extends StatefulWidget {
  const Registrar1({super.key});

  @override
  State<Registrar1> createState() => _Registrar1State();
}

class _Registrar1State extends State<Registrar1> {
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  bool _isRegistering = false;

  Future<void> _registrar() async {
    if (_isRegistering) return;

    if (_nome.text.trim().isEmpty ||
        _email.text.trim().isEmpty ||
        _senha.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _isRegistering = true);

    try {
      final ok = await ApiServices.registrar(
        name: _nome.text.trim(),
        email: _email.text.trim(),
        password: _senha.text,
      );
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ok ? 'Conta criada com sucesso!' : 'Não foi possível criar a conta.',
          ),
        ),
      );
      if (ok) Navigator.pop(context);
    } on DioException catch (error) {
      if (!mounted) return;
      final message = switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          'O servidor demorou demasiado a responder. Tente novamente.',
        DioExceptionType.connectionError =>
          'Falha de rede. Verifique a ligação à internet.',
        DioExceptionType.badResponse =>
          'O servidor recusou o registo. Verifique os dados e tente novamente.',
        _ => 'Ocorreu um erro ao comunicar com o servidor.',
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) setState(() => _isRegistering = false);
    }
  }

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registar', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Customtextfild(
                hintText: 'Nome',
                prefixIcon: Icons.person,
                controller: _nome,
              ),
              const SizedBox(height: 10),
              Customtextfild(
                hintText: 'Email',
                prefixIcon: Icons.email_rounded,
                controller: _email,
              ),
              const SizedBox(height: 10),
              Customtextfild(
                hintText: 'Senha',
                prefixIcon: Icons.lock,
                obscureText: true,
                controller: _senha,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isRegistering ? null : _registrar,
                  child: _isRegistering
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 12),
                            Text('A criar conta...'),
                          ],
                        )
                      : const Text('Registar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}