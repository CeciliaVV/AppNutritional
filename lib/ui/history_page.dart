import 'package:appnutritional/bloc/food_cubit.dart';
import 'package:appnutritional/bloc/index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ListaHistorial extends StatefulWidget {
  ListaHistorial({Key? key}) : super(key: key);

  @override
  _ListaHistorialState createState() => _ListaHistorialState();
}

class _ListaHistorialState extends State<ListaHistorial> {
  List<String> miHistorial = [];
  List<String> miTipo = [];

  Future<void> getHistorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> aux = (prefs.getStringList('_keyHistorial') ?? []);
    List<String> aux2 = (prefs.getStringList('_keyTipo') ?? []);
    //print('captado en Lista_historial $miHistorial');
    setState(() {
      miHistorial = aux;
      miTipo = aux2;
    });
  }

  borrar(int index) {
    int num = miHistorial.length;
    setState(() {
      miHistorial.removeAt(num - index - 1);
      miTipo.remove(num - index - 1);
    });
  }

  int arreglo() {
    getHistorial();
    print('arr: $miHistorial');
    return miHistorial.length;
  }

  @override
  void initState() {
    //getHistorial();
    super.initState();
    //getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //reverse: true,
        itemCount: arreglo(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(miHistorial[miHistorial.length - index - 1].toString()),
            trailing: IconButton(
                onPressed: () async {
                  borrar(index);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setStringList('_keyHistorial', miHistorial);
                  prefs.setStringList('_keyTipo', miTipo);
                },
                icon: Icon(Icons.close)),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<String> tipos = (prefs.getStringList('_keyTipo') ?? []);
              print(tipos[index]);
              /*tipos[tipos.length - index - 1] == 'FOOD'
                  ? BlocProvider.of<IndexCubit>(context).changePage(1)
                  : BlocProvider.of<IndexCubit>(context).changePage(2);*/
              //BlocProvider.of<FoodCubit>(context).queryController.text = miHistorial[tipos.length-index-1];
              //BlocProvider.of<FoodCubit>(context).getFoodSearched();
            },
          );
        });
  }
}
