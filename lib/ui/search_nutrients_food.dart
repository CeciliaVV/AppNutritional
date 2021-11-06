import 'package:appnutritional/bloc/food_cubit.dart';
import 'package:appnutritional/models/food_list.dart';
import 'package:appnutritional/models/nutrients_food.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size tam = MediaQuery.of(context).size;
    double ancho = tam.width;
    double alto = tam.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: ancho * 0.6,
              height: alto * 0.1,
              child: TextFormField(
                controller: BlocProvider.of<FoodCubit>(context).queryController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black87,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Colors.black, style: BorderStyle.solid)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Colors.black, style: BorderStyle.solid)),
                  hintText: "Search your food",
                  hintStyle: TextStyle(color: Colors.black87),
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              width: ancho * 0.3,
              height: alto * 0.1,
              //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                onPressed: () {
                  BlocProvider.of<FoodCubit>(context).getFoodSearched();
                },
                //color: Colors.lightBlue,
                child: const Text(
                  "Search",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            )
          ],
        ),
        BlocBuilder<FoodCubit, FoodState>(builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: Text("Search something"),
            );
          } else if (state is FoodSearchingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FoodSearchedState) {
            return BlocProvider.value(
                value: BlocProvider.of<FoodCubit>(context),
                child: ShowListFood(
                    foods: state
                        .foods)); /*Center(
                child: SizedBox(
              width: ancho,
              height: alto * 0.8,
              child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  leading: SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.network(
                        "https://spoonacular.com/cdn/ingredients_250x250/${state.foods[index].image}"),
                  ),
                  title: Text(
                    "${index + 1}. ${state.foods[index].name}",
                    style: const TextStyle(color: Colors.green),
                  ),
                  onTap: () {
                    foodCubit.getutrientsFood(
                        state.foods[index].id, state.foods[index].image);
                  },
                ),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.green[900],
                ),
                itemCount: state.foods.length,
              ),
            ));*/
          } else if (state is DetailFoodChargedState) {
            return BlocProvider.value(
                value: BlocProvider.of<FoodCubit>(context),
                child: DetailFood(
                    nutrients: state.nutrients,
                    image: state
                        .image)); /*Center(
              child: Column(
                children: [
                  SizedBox(
                    height: alto * 0.25,
                    width: ancho * 0.25,
                    child: Image.network(
                        "https://spoonacular.com/cdn/ingredients_250x250/${state.image}"),
                  ),
                  Text(
                    "Percent carbohydrates: ${state.nutrients.percentCarbs}",
                    style: const TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  Text(
                    "Percent proteins: ${state.nutrients.percentProtein}",
                    style: const TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  Text(
                    "Percent  Fat: ${state.nutrients.percentFat}",
                    style: const TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ],
              ),
            );*/
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        })
      ],
    );
  }
}

class ShowListFood extends StatelessWidget {
  final List<Food> foods;

  const ShowListFood({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size tam = MediaQuery.of(context).size;
    double ancho = tam.width;
    double alto = tam.height;

    return SizedBox(
      width: ancho,
      height: alto,
      child: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          leading: SizedBox(
            height: ancho * 0.1,
            width: alto * 0.1,
            child: Image.network(
                "https://spoonacular.com/cdn/ingredients_250x250/${foods[index].image}"),
          ),
          title: Text(
            "${index + 1}. ${foods[index].name}",
            style: const TextStyle(color: Colors.green),
          ),
          onTap: () {
            BlocProvider.of<FoodCubit>(context)
                .getutrientsFood(foods[index].id, foods[index].image);
          },
        ),
        separatorBuilder: (context, index) => Divider(
          color: Colors.green[900],
        ),
        itemCount: foods.length,
      ),
    );
  }
}

class DetailFood extends StatelessWidget {
  final Macronutrients nutrients;
  final String image;
  const DetailFood({Key? key, required this.nutrients, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size tam = MediaQuery.of(context).size;
    double ancho = tam.width;
    double alto = tam.height;

    return Column(
      children: [
        SizedBox(
          height: ancho * 0.25,
          width: alto * 0.25,
          child: Image.network(
              "https://spoonacular.com/cdn/ingredients_250x250/$image"),
        ),
        Text(
          "Percent carbohydrates: ${nutrients.percentCarbs}",
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        Text(
          "Percent proteins: ${nutrients.percentProtein}",
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        Text(
          "Percent  Fat: ${nutrients.percentFat}",
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
      ],
    );
  }
}
