import 'package:flutter/material.dart';
import 'package:listadecompras/models/lista_models.dart';
import 'package:listadecompras/repositories/lista_repository.dart';
import 'package:listadecompras/screen/create_itens_screen.dart';
import 'package:listadecompras/widget/lista_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sistema de reservas"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateItensScreen(
                onChange: () {
                  setState(() {

                  });
                },
                listaModel:
                ListaModel(item: "", comprado: false)),
          ));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: ListaRepositorio.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.red),
              ),
            );

          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          if (snapshot.data!.length == 0)
            return Center(
              child: Text("Nenhuma reserva adicionada"),
            );

          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListaTile(
                listaModel: snapshot.data![index],
                onChange: () {
                  setState(() {});
                },
              ));
        },
      ),
    );
  }
}