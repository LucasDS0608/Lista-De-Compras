import 'package:flutter/material.dart';
import 'package:listadecompras/models/lista_models.dart';
import 'package:listadecompras/repositories/lista_repository.dart';

class EditListTile extends StatefulWidget {
  final ListaModel listaModel;
  final VoidCallback onUpdate;

  EditListTile({required this.listaModel, required this.onUpdate, super.key});

  @override
  State<EditListTile> createState() => _EditListTileState();
}

class _EditListTileState extends State<EditListTile> {
  late TextEditingController itemController;

  @override
  void initState() {
    itemController = TextEditingController(text: widget.listaModel.item);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
      Text(widget.listaModel.id == null ? "Novo item" : "Editar item"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: itemController,
          decoration: InputDecoration(labelText: "Item"),
        ),
      ),
      actions: [TextButton(onPressed: () async {
        widget.listaModel.item = itemController.text;

        if (widget.listaModel.id == null) {
          await ListaRepositorio.add(widget.listaModel);
        } else {
          await ListaRepositorio.update(widget.listaModel);
        }

        widget.onUpdate();

        Navigator.of(context).pop();
      }, child: Text("Salvar"))],
    );
  }
}
