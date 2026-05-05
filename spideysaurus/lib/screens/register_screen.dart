import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SPIDEY SAURUS")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.red, 
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "NUEVO REGISTRO", 
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _email, 
                  decoration: const InputDecoration(labelText: "Correo")
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _pass, 
                  decoration: const InputDecoration(labelText: "Contraseña"), 
                  obscureText: true
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _confirmPass, 
                  decoration: const InputDecoration(labelText: "Confirmar Contraseña"), 
                  obscureText: true
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_pass.text != _confirmPass.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Las contraseñas no coinciden"))
                      );
                      return;
                    }
                    try {
                      // 1. Crear el usuario en Firebase
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _email.text.trim(), 
                        password: _pass.text.trim()
                      );
                      
                      // 2. Mostrar mensaje de éxito
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("¡Registro exitoso! Ahora inicia sesión"))
                      );

                      // 3. REGRESAR A LA PANTALLA DE LOGIN
                      // Usamos pushReplacementNamed para limpiar la ruta de registro
                      Navigator.pushReplacementNamed(context, '/');
                      
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e"))
                      );
                    }
                  },
                  child: const SizedBox(
                    width: double.infinity, 
                    child: Center(child: Text("REGISTRAR Y VOLVER"))
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}