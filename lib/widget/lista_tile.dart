import 'package:flutter/material.dart';
import 'package:listadecompras/models/lista_models.dart';
import 'package:listadecompras/screen/create_itens_screen.dart';
import 'package:listadecompras/repositories/lista_repository.dart';

class ListaTile extends StatefulWidget {
  final ListaModel listaModel;
  final VoidCallback onChange;

  const ListaTile({required this.listaModel, required this.onChange, super.key});

  @override
  State<ListaTile> createState() => _ListaTileState();
}

class _ListaTileState extends State<ListaTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.listaModel.item  }'),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateItemScreen(
            listaModel: widget.listaModel)));
      },
      leading: Checkbox(
        value: widget.listaModel.comprado,
        onChanged: (value) async {
          widget.listaModel.comprado = value ?? false;
          ListaRepositorio.update(widget.listaModel);
          setState(() {

          });
        },
      ),
      trailing: IconButton(
        onPressed: () async {

          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text("Exclusão"),
              content: Text("Deseja realmente excluir?"),
              actions: [
                TextButton(onPressed: () async {
                  await ListaRepositorio.delete(widget.listaModel);



                  Navigator.pop(context);
                }, child: Text("Sim")),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("Não"))
              ],
            );
          },);
        },
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}

