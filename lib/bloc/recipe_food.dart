import 'package:appnutritional/models/detail_food.dart';
import 'package:appnutritional/models/recipes_list.dart';
import 'package:appnutritional/repository/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final Api api;

  RecipeCubit(this.api) : super(InitialStateRecipe());

  final queryController = TextEditingController();

  Future getRecipeSearched() async {
    emit(RecipeSearchingState());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> miHistorial = (prefs.getStringList('_keyHistorial') ?? []);
    miHistorial.add(queryController.text);
    await prefs.setStringList('_keyHistorial', miHistorial);
    List<String> typeSearch = (prefs.getStringList('_keyTipo') ?? []);
    typeSearch.add('RECIPE');
    await prefs.setStringList('_keyTipo', typeSearch);
    try {
      final recipes = await api.getRecipes(queryController.text);
      print(recipes.toString());
      if (recipes.isEmpty) {
        emit(ErrorState("No results found. Try agin."));
      } else {
        emit(RecipeSearchedState(recipes));
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }

  Future getDetailRecipe(int id) async {
    emit(RecipeSearchingState());

    try {
      final detail = await api.getDetailRecipe(id);
      print(detail.toString());
      if (detail.link == " ") {
        emit(ErrorState("No results found. Try agin."));
        //emit(NoFoodSearchedState());
      } else {
        emit(DetailRecipeChargedState(detail));
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }
}

abstract class RecipeState {}

class InitialStateRecipe extends RecipeState {}

class RecipeSearchingState extends RecipeState {}

class RecipeSearchedState extends RecipeState {
  final List<Recipe> recipes;

  RecipeSearchedState(this.recipes);
}

class DetailRecipeChargedState extends RecipeState {
  final DetailRecipe detail;
  DetailRecipeChargedState(this.detail);
}

class ErrorState extends RecipeState {
  final String message;
  ErrorState(this.message);
}
