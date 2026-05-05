import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importante para el logout

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SPIDEY SAURUS"),
        // Agregamos el icono de salida en la parte derecha
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: () async {
              // 1. Cerramos la sesión en Firebase
              await FirebaseAuth.instance.signOut();
              // 2. Regresamos a la pantalla de Login (ruta '/')
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('productos').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Colors.yellow));
          
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    doc['urlImagen'], 
                    width: 60, 
                    height: 60, 
                    fit: BoxFit.cover, 
                    errorBuilder: (c, e, s) => const Icon(Icons.broken_image),
                  ),
                  title: Text(doc['nombre'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${doc['marca']} - \$${doc['precio']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue), 
                        onPressed: () => Navigator.pushNamed(context, '/add_product', arguments: doc),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red), 
                        onPressed: () => doc.reference.delete(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () => Navigator.pushNamed(context, '/add_product'),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}