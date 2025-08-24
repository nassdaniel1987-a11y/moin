enum MealType {
  breakfast,
  lunch,
  dinner,
  snacks,
}

// Helper extension for display names
extension MealTypeName on MealType {
  String get name {
    switch (this) {
      case MealType.breakfast:
        return 'Frühstück';
      case MealType.lunch:
        return 'Mittagessen';
      case MealType.dinner:
        return 'Abendessen';
      case MealType.snacks:
        return 'Snacks';
    }
  }
}
