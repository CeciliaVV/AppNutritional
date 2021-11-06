class ListRecipe {
  ListRecipe();
  static List<Recipe> recipeFromJson(List<dynamic> jsonList) {
    List<Recipe> listRecipe = [];
    for (var rec in jsonList) {
      final recipe = Recipe.fromJson(rec);
      listRecipe.add(recipe);
    }
    return listRecipe;
  }
}

class Recipe {
  int id;
  String title;
  String image;
  String imageType;

  Recipe(
    this.id,
    this.title,
    this.image,
    this.imageType,
  );

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        json["id"],
        json["title"],
        json["image"],
        json["imageType"],
      );
  @override
  String toString() {
    return '$id + $title + $image';
  }
}
