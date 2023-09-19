import 'package:flutter/material.dart';
import 'package:listadecompras/models/lista_models.dart';
import 'package:listadecompras/screen/create_itens_screen.dart';
import 'package:listadecompras/repositories/lista_repository.dart';


class ListaTile extends StatefulWidget {
  final ListaModel listaModel;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ListaTile({
    required this.listaModel,
    required this.onEdit,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<ListaTile> createState() => _ListaTileState();
}

class _ListaTileState extends State<ListaTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: widget.onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
      onTap: widget.onEdit,
      leading: Checkbox(
        value: widget.listaModel.comprado,
        onChanged: (value) async {
          widget.listaModel.comprado = value ?? false;

          await ListaRepositorio.update(widget.listaModel);

          setState(() {});
        },
      ),
      title: Text(widget.listaModel.item),
    );
  }

  // Função para exibir o diálogo de confirmação de exclusão
  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Deseja realmente excluir este item?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () async {
                await ListaRepositorio.delete(widget.listaModel);
                widget.onDelete(); // Atualizar a lista após a exclusão
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


