import 'package:appnutritional/bloc/food_cubit.dart';
import 'package:appnutritional/bloc/recipe_food.dart';
import 'package:appnutritional/repository/api.dart';
import 'package:appnutritional/ui/history_page.dart';
import 'package:appnutritional/ui/home_page.dart';
import 'package:appnutritional/ui/search_nutrients_food.dart';
import 'package:appnutritional/ui/search_recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/index_cubit.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(BlocProvider(create: (context) => IndexCubit(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final foodcubit = FoodCubit(Api());
  final recipeCubit = RecipeCubit(Api());
  int curentIndex = 0;
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: BlocBuilder<IndexCubit, IndexState>(builder: (_, state) {
          if (state.indexValue == 0) {
            curentIndex = state.indexValue;
            return const HomePage();
          } else if (state.indexValue == 1) {
            curentIndex = state.indexValue;
            return SingleChildScrollView(
              child: BlocProvider.value(
                  value: foodcubit, child: const SearchPage()),
            );
          } else if (state.indexValue == 2) {
            curentIndex = state.indexValue;
            return SingleChildScrollView(
              child: BlocProvider.value(
                  value: recipeCubit, child: const RecipePage()),
            );
          } else if (state.indexValue == 3) {
            curentIndex = state.indexValue;
            return BlocProvider.value(
                value: recipeCubit, child: const HistoryPage());
          } else {
            curentIndex = state.indexValue;
            return const HomePage();
          }
        }),
        bottomNavigationBar:
            BlocBuilder<IndexCubit, IndexState>(builder: (_, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: curentIndex,
            onTap: (index) {
              curentIndex =
                  BlocProvider.of<IndexCubit>(context).changePage(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flatware),
                label: 'Food',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_rounded),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_edu_sharp),
                label: 'History',
              ),
            ],
          );
        }),
      ),
    );
  }
}
