import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SPIDEY SAURUS")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                TextField(controller: _email, decoration: const InputDecoration(labelText: "Usuario (Correo)")),
                const SizedBox(height: 10),
                TextField(controller: _pass, decoration: const InputDecoration(labelText: "Contraseña"), obscureText: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text.trim(), password: _pass.text.trim());
                      Navigator.pushReplacementNamed(context, '/products');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
                    }
                  },
                  child: const SizedBox(width: double.infinity, child: Center(child: Text("INGRESAR"))),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text("¿NUEVO AQUÍ? REGÍSTRATE", style: TextStyle(color: Colors.yellow)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}