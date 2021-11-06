class ListFood {
  ListFood();
  static List<Food> foodFromJson(List<dynamic> jsonList) {
    List<Food> listaFood = [];
    for (var food in jsonList) {
      final aliment = Food.fromJson(food);
      listaFood.add(aliment);
    }
    return listaFood;
  }
}

class Food {
  int id;
  String name;
  String image;

  Food(
    this.id,
    this.name,
    this.image,
  );

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        json["id"],
        json["name"],
        json["image"],
      );
  @override
  String toString() {
    return '$id + $name + $image';
  }
}
