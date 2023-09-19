import 'package:flutter/material.dart';
import 'package:listadecompras/models/lista_models.dart';
import 'package:listadecompras/repositories/lista_repository.dart';

class CreateItensScreen extends StatefulWidget {
  final VoidCallback onChange;
  final ListaModel listaModel;

  CreateItensScreen({required this.onChange, required this.listaModel, super.key});

  @override
  State<CreateItensScreen> createState() => _CreateItensScreenState();
}

class _CreateItensScreenState extends State<CreateItensScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController itemController = TextEditingController();

  @override
  void initState() {
    itemController.text = widget.listaModel.item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.listaModel.id ==null ? "Novo item" : "Editar item"),
        actions: [
          IconButton(onPressed: () async {
            if (formKey.currentState!.validate()) {
              itemController.text = widget.listaModel.item;

              if (widget.listaModel.id == null) {
                await ListaRepositorio.add(widget.listaModel);
              } else {
                await ListaRepositorio.update(widget.listaModel);
              }
              widget.onChange();
              Navigator.pop(context);
            }
          }, icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if ((value ?? "") == "")
                      return "O campo é obrigatório";
                  },
                  controller: itemController,
                  decoration: InputDecoration(
                      labelText: "Item"
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
