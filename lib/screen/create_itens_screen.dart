import 'package:flutter/material.dart';
import 'package:listadecompras/models/lista_models.dart';
import 'package:listadecompras/repositories/lista_repository.dart';


class CreateItemScreen extends StatefulWidget {
  final ListaModel listaModel;

  const CreateItemScreen({required this.listaModel, super.key});

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.listaModel.id == null ? "Novo item" : "Editar item"),
      ),
    );
  }
}


