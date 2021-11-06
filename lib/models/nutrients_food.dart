import 'dart:convert';

Macronutrients macronutrientsFromJson(String str) =>
    Macronutrients.fromJson(json.decode(str));

String macronutrientsToJson(Macronutrients data) => json.encode(data.toJson());

class Macronutrients {
  double percentProtein;
  double percentFat;
  double percentCarbs;

  Macronutrients(
    this.percentProtein,
    this.percentFat,
    this.percentCarbs,
  );

  factory Macronutrients.fromJson(Map<String, dynamic> json) => Macronutrients(
        json["percentProtein"],
        json["percentFat"],
        json["percentCarbs"],
      );

  Map<String, dynamic> toJson() => {
        "percentProtein": percentProtein,
        "percentFat": percentFat,
        "percentCarbs": percentCarbs,
      };
}
