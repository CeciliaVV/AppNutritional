import 'package:appnutritional/bloc/history_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  List<String> miHistorial = [];
  List<String> newHis = [];
  getHistorial(List<String> miHist) {
    return ListView.builder(
        //reverse: true,
        itemCount: miHist.length,
        itemBuilder: (context, index) {
          print(miHistorial);
          return ListTile(
            title: Text(miHistorial[miHist.length - index - 1].toString()),
            trailing: IconButton(
                onPressed: () {
                  BlocProvider.of<HistoryCubit>(context).eraseHistory(index);
                  newHis = BlocProvider.of<HistoryCubit>(context).miHistorial;
                },
                icon: const Icon(Icons.close)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(builder: (context, state) {
      getValue() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        miHistorial = (prefs.getStringList('_keyHistorial') ?? []);
      }

      getValue();
      print(miHistorial);
      if (state is InitialStateHistory) {
        return getHistorial(miHistorial);
      } else if (state is EraseState) {
        return getHistorial(newHis);
      } else {
        return const Center(
          child: Text("Error"),
        );
      }
    });
  }
}
