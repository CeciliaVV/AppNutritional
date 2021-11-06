import 'dart:convert';

DetailRecipe detailRecipeFromJson(String str) =>
    DetailRecipe.fromJson(json.decode(str));

class DetailRecipe {
  String link;

  DetailRecipe(this.link);

  factory DetailRecipe.fromJson(String json) => DetailRecipe(
        json,
      );
  @override
  String toString() {
    return link;
  }
}
