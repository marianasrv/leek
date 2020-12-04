import 'Month.dart';

class Crop {
  String name;
  Month bestMonth;
  Type type;
  Difficulty difficulty;

  Crop({this.name, this.bestMonth, this.type, this.difficulty});
}

enum Difficulty {
  easy,
  medium,
  hard,
}

enum Type { vegetable, fruit, herb }

List allCrops() {
  return [
    Crop(
        name: "Pineaple",
        bestMonth: Month.january,
        type: Type.fruit,
        difficulty: Difficulty.hard),
    Crop(
        name: "Apple",
        bestMonth: Month.march,
        type: Type.fruit,
        difficulty: Difficulty.medium),
    Crop(
        name: "Blueberries",
        bestMonth: Month.june,
        type: Type.fruit,
        difficulty: Difficulty.hard),
    Crop(
        name: "Oregano",
        bestMonth: Month.september,
        type: Type.herb,
        difficulty: Difficulty.easy),
    Crop(
        name: "Lettuce",
        bestMonth: Month.april,
        type: Type.vegetable,
        difficulty: Difficulty.easy),
    Crop(
        name: "Brussel Sprouts",
        bestMonth: Month.october,
        type: Type.vegetable,
        difficulty: Difficulty.medium),
  ];
}
