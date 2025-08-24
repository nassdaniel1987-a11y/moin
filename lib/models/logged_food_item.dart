import 'food_item.dart';

class LoggedFoodItem {
  final FoodItem foodItem;
  final double amount; // in grams

  LoggedFoodItem({
    required this.foodItem,
    required this.amount,
  });

  // Calculated properties for convenience
  double get totalCalories => (foodItem.calories / 100) * amount;
  double get totalProtein => (foodItem.protein / 100) * amount;
  double get totalCarbs => (foodItem.carbs / 100) * amount;
  double get totalFat => (foodItem.fat / 100) * amount;
}
