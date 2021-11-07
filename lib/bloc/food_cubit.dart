import 'package:appnutritional/models/food_list.dart';
import 'package:appnutritional/models/nutrients_food.dart';
import 'package:appnutritional/repository/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodCubit extends Cubit<FoodState> {
  final Api api;

  FoodCubit(this.api) : super(InitialState());

  final queryController = TextEditingController();

  Future getFoodSearched() async {
    emit(FoodSearchingState());

    try {
      final foods = await api.getFood(queryController.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> miHistorial = (prefs.getStringList('_keyHistorial') ?? []);
      miHistorial.add(queryController.text);
      await prefs.setStringList('_keyHistorial', miHistorial);
      List<String> typeSearch = (prefs.getStringList('_keyTipo') ?? []);
      typeSearch.add('FOOD');
      await prefs.setStringList('_keyTipo', typeSearch);
      print(foods.toString());
      if (foods.isEmpty) {
        emit(ErrorState("No results found. Try agin."));
      } else {
        emit(FoodSearchedState(foods));
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }

  Future getutrientsFood(int id, String image) async {
    emit(FoodSearchingState());

    try {
      final nutrients = await api.getMacroNutrients(id);
      print(nutrients.toString());
      if (nutrients.percentCarbs == -1) {
        emit(ErrorState("No results found. Try agin."));
        //emit(NoFoodSearchedState());
      } else {
        emit(DetailFoodChargedState(nutrients, image));
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }
}

abstract class FoodState {}

class InitialState extends FoodState {}

class FoodSearchingState extends FoodState {}

class FoodSearchedState extends FoodState {
  final List<Food> foods;

  FoodSearchedState(this.foods);
}

class DetailFoodChargedState extends FoodState {
  final Macronutrients nutrients;
  String image;
  DetailFoodChargedState(this.nutrients, this.image);
}

class ErrorState extends FoodState {
  final String message;
  ErrorState(this.message);
}
