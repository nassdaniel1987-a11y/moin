class FoodItem {
  final String id;
  final String name;
  final String brand;
  final double calories; // per 100g
  final double protein;  // per 100g
  final double carbs;    // per 100g
  final double fat;      // per 100g
  final double servingSize; // in grams
  final String? barcode;

  FoodItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.servingSize = 100.0,
    this.barcode,
  });

  /// A factory constructor for creating a new FoodItem instance from a map.
  /// This is useful for parsing JSON responses from an API.
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    final nutriments = json['product']['nutriments'] ?? {};
    return FoodItem(
      id: json['code'] ?? '',
      name: json['product']['product_name'] ?? 'Unknown',
      brand: json['product']['brands'] ?? 'Unknown',
      // The API might return values as String or num, so we parse defensively.
      calories: double.tryParse(nutriments['energy-kcal_100g']?.toString() ?? '0.0') ?? 0.0,
      protein: double.tryParse(nutriments['proteins_100g']?.toString() ?? '0.0') ?? 0.0,
      carbs: double.tryParse(nutriments['carbohydrates_100g']?.toString() ?? '0.0') ?? 0.0,
      fat: double.tryParse(nutriments['fat_100g']?.toString() ?? '0.0') ?? 0.0,
      barcode: json['code'],
    );
  }
}
