import 'package:appnutritional/bloc/recipe_food.dart';
import 'package:appnutritional/models/detail_food.dart';
import 'package:appnutritional/models/recipes_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key? key}) : super(key: key);

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
                controller:
                    BlocProvider.of<RecipeCubit>(context).queryController,
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
                  hintText: "Search your recipe",
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
                  BlocProvider.of<RecipeCubit>(context).getRecipeSearched();
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
        BlocBuilder<RecipeCubit, RecipeState>(builder: (context, state) {
          if (state is InitialStateRecipe) {
            return const Center(
              child: Text("Search something"),
            );
          } else if (state is RecipeSearchingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RecipeSearchedState) {
            return BlocProvider.value(
                value: BlocProvider.of<RecipeCubit>(context),
                child: ShowListRecipe(recipes: state.recipes));
          } else if (state is DetailRecipeChargedState) {
            return BlocProvider.value(
                value: BlocProvider.of<RecipeCubit>(context),
                child: DetailRecipePage(detail: state.detail));
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        }),
      ],
    );
  }
}

class ShowListRecipe extends StatelessWidget {
  final List<Recipe> recipes;

  const ShowListRecipe({Key? key, required this.recipes}) : super(key: key);

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
            child: Image.network(recipes[index].image),
          ),
          title: Text(
            "${index + 1}. ${recipes[index].title}",
            style: const TextStyle(color: Colors.green),
          ),
          onTap: () {
            BlocProvider.of<RecipeCubit>(context)
                .getDetailRecipe(recipes[index].id);
          },
        ),
        separatorBuilder: (context, index) => Divider(
          color: Colors.green[900],
        ),
        itemCount: recipes.length,
      ),
    );
  }
}

class DetailRecipePage extends StatelessWidget {
  final DetailRecipe detail;
  const DetailRecipePage({Key? key, required this.detail}) : super(key: key);

  //if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  @override
  Widget build(BuildContext context) {
    final Size tam = MediaQuery.of(context).size;
    double ancho = tam.width;
    double alto = tam.height;
    return SizedBox(
      width: ancho,
      height: alto,
      child: WebView(
        initialUrl: detail.link,
        //JS unrestricted, so that JS can execute in the webview
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
