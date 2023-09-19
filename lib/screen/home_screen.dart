import 'package:flutter/material.dart';
import 'package:listadecompras/models/lista_models.dart';
import 'package:listadecompras/repositories/lista_repository.dart';
import 'package:listadecompras/screen/create_itens_screen.dart';
import 'package:listadecompras/widget/edit_list_tile.dart';
import 'package:listadecompras/widget/lista_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _add() {
    showDialog(context: context, builder: (context) {
      return EditListTile(
        onUpdate: () {
          setState(() {

          });
        },
        listaModel: ListaModel(item: "", comprado: false),
      );
    });
  }

  void _edit(ListaModel listaItemModel) {
    showDialog(context: context, builder: (context) {
      return EditListTile(listaModel: listaItemModel, onUpdate: () {
        setState(() {

        });
      },);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: ListaRepositorio.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.error.toString()),
            );

          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          if ((snapshot.hasData) && (snapshot.data!.length == 0))
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Nenhum item ainda adicionado"),
                  TextButton(
                      onPressed: _add, child: Text("Adicionar novo item"))
                ],
              ),
            );

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) =>
                ListaTile(listaModel: snapshot.data![index], onChange: () {
                  _edit(snapshot.data![index]);
                },),
          );
        },
      ),
    );
  }
}