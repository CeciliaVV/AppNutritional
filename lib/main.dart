import 'package:appnutritional/bloc/food_cubit.dart';
import 'package:appnutritional/bloc/history_cubit.dart';
import 'package:appnutritional/bloc/recipe_food.dart';
import 'package:appnutritional/repository/api.dart';
import 'package:appnutritional/ui/history_page.dart';
import 'package:appnutritional/ui/home_page.dart';
import 'package:appnutritional/ui/search_nutrients_food.dart';
import 'package:appnutritional/ui/search_recipes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/index_cubit.dart';

void main() {
  runApp(BlocProvider(create: (context) => IndexCubit(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final foodcubit = FoodCubit(Api());
  final recipeCubit = RecipeCubit(Api());
  int currentIndex = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final historyCubit = HistoryCubit();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SafeArea(
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.green[100],
          body: BlocBuilder<IndexCubit, IndexState>(builder: (_, state) {
            if (state.indexValue == 0) {
              currentIndex = 0;
              return BlocProvider.value(
                  value: BlocProvider.of<IndexCubit>(context),
                  child: const HomePage());
            } else if (state.indexValue == 1) {
              currentIndex = 1;
              //BlocProvider.of<IndexCubit>(context).changePage(1);
              return SingleChildScrollView(
                child: BlocProvider.value(
                    value: foodcubit, child: const SearchPage()),
              );
            } else if (state.indexValue == 2) {
              currentIndex = 2;
              //BlocProvider.of<IndexCubit>(context).changePage(2);
              return SingleChildScrollView(
                child: BlocProvider.value(
                    value: recipeCubit, child: const RecipePage()),
              );
            } else if (state.indexValue == 3) {
              currentIndex = 3;
              //BlocProvider.of<IndexCubit>(context).changePage(3);
              return BlocProvider.value(
                  value: historyCubit, child: ListaHistorial());
            } else {
              currentIndex = 0;
              return const HomePage();
            }
          }),
          bottomNavigationBar:
              BlocBuilder<IndexCubit, IndexState>(builder: (_, state) {
            return CurvedNavigationBar(
              index: state.indexValue == 1
                  ? 1
                  : (state.indexValue == 2
                      ? 2
                      : state.indexValue == 3
                          ? 3
                          : 0),
              color: Colors.greenAccent,
              //buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              height: 60,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              onTap: (index) {
                currentIndex =
                    BlocProvider.of<IndexCubit>(context).changePage(index);
              },
              items: const [
                Icon(
                  Icons.home,
                ),
                Icon(Icons.flatware),
                Icon(Icons.receipt_rounded),
                Icon(Icons.history_edu_sharp),
              ],
            );
          }),
        ),
      ),
    );
  }
}
