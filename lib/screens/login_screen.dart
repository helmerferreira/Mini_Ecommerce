import 'package:flutter/material.dart';
import 'widget_login.dart';
import 'registrar_1.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                ),
                SizedBox(height: 10),
                Customtextfild(
                  hintText: "Senha",
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
              ],
            ),
          ),
          Container(
            
            padding: EdgeInsets.all(8),
          child:
          Column(
            children: [
               FractionallySizedBox(
            widthFactor: 0.5,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Entrar"),
            ),
            
          ),
          SizedBox(height: 10,),
              
              
          FractionallySizedBox(
            widthFactor: 0.5,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Registrar1()),
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
