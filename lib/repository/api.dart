import 'package:appnutritional/models/detail_food.dart';
import 'package:appnutritional/models/food_list.dart';
import 'package:appnutritional/models/nutrients_food.dart';
import 'package:appnutritional/models/recipes_list.dart';
import 'package:appnutritional/ui/search_nutrients_food.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  List<Food> foods = [];
  List<Recipe> recipes = [];
  DetailRecipe detRec = DetailRecipe(" ");
  Macronutrients nutrients = Macronutrients(-1, -1, -1);

  Future<List<Food>> getFood(String aliment) async {
    final response = await http.Client().get(Uri.parse(
        "https://api.spoonacular.com/food/ingredients/search?query=$aliment&number=15&apiKey=dc37663c66eb4f83a06b350a8a3363d2"));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      print(data["results"]);
      foods = ListFood.foodFromJson(data["results"]);
      print(foods);
    } else {
      throw Exception("No funcionó el llamado a la api");
    }

    return foods;
  }

  Future<Macronutrients> getMacroNutrients(int id) async {
    final response = await http.Client().get(Uri.parse(
        "https://api.spoonacular.com/food/ingredients/$id/information?amount=150&unit=grams&apiKey=dc37663c66eb4f83a06b350a8a3363d2"));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      print(data["nutrition"]);
      print(data["nutrition"]["caloricBreakdown"]);
      nutrients =
          Macronutrients.fromJson(data["nutrition"]["caloricBreakdown"]);
      print(nutrients);
    } else {
      throw Exception("No funcionó el llamado a la api");
    }

    return nutrients;
  }

  Future<List<Recipe>> getRecipes(String word) async {
    final response = await http.Client().get(Uri.parse(
        "https://api.spoonacular.com/recipes/complexSearch?query=$word&number=15&apiKey=dc37663c66eb4f83a06b350a8a3363d2"));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      print(data["results"]);
      recipes = ListRecipe.recipeFromJson(data["results"]);
      print(recipes);
    } else {
      throw Exception("No funcionó el llamado a la api de lista de recetas");
    }

    return recipes;
  }

  Future<DetailRecipe> getDetailRecipe(int id) async {
    final response = await http.Client().get(Uri.parse(
        "https://api.spoonacular.com/recipes/$id/information?includeNutrition=false&apiKey=dc37663c66eb4f83a06b350a8a3363d2"));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      print(data["sourceUrl"]);
      detRec = DetailRecipe.fromJson(data["sourceUrl"]);
      print(detRec);
    } else {
      throw Exception("No funcionó el llamado a la api de recetas");
    }

    return detRec;
  }
}
