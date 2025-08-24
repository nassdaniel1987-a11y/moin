import 'logged_food_item.dart';
import 'meal_type.dart';

class Meal {
  final MealType mealType;
  final List<LoggedFoodItem> items;

  Meal({
    required this.mealType,
    this.items = const [],
  });

  double get totalCalories => items.fold(0.0, (sum, item) => sum + item.totalCalories);
  double get totalProtein => items.fold(0.0, (sum, item) => sum + item.totalProtein);
  double get totalCarbs => items.fold(0.0, (sum, item) => sum + item.totalCarbs);
  double get totalFat => items.fold(0.0, (sum, item) => sum + item.totalFat);
}
