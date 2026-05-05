import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({super.key});
  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _nombre = TextEditingController();
  final _marca = TextEditingController();
  final _precio = TextEditingController();
  final _url = TextEditingController();
  String? _id;

  @override
  void didChangeDependencies() {
    final doc = ModalRoute.of(context)?.settings.arguments as DocumentSnapshot?;
    if (doc != null) {
      _id = doc.id;
      _nombre.text = doc['nombre'];
      _marca.text = doc['marca'];
      _precio.text = doc['precio'].toString();
      _url.text = doc['urlImagen'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_id == null ? "NUEVO PRODUCTO" : "EDITAR PRODUCTO")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                TextField(controller: _nombre, decoration: const InputDecoration(labelText: "Nombre")),
                const SizedBox(height: 10),
                TextField(controller: _marca, decoration: const InputDecoration(labelText: "Marca")),
                const SizedBox(height: 10),
                TextField(controller: _precio, decoration: const InputDecoration(labelText: "Precio"), keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                TextField(controller: _url, decoration: const InputDecoration(labelText: "URL Imagen")),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final data = {'nombre': _nombre.text, 'marca': _marca.text, 'precio': double.parse(_precio.text), 'urlImagen': _url.text};
                    _id == null 
                      ? await FirebaseFirestore.instance.collection('productos').add(data)
                      : await FirebaseFirestore.instance.collection('productos').doc(_id).update(data);
                    Navigator.pop(context);
                  },
                  child: const SizedBox(width: double.infinity, child: Center(child: Text("GUARDAR"))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}