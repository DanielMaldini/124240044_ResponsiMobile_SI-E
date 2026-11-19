class Recipe {
  final int id;
  final String name;
  final String image;
  final String cuisine;
  final double rating;
  final int reviewCount;
  final String difficulty;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final int caloriesPerServing;
  final List<String> mealType;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.cuisine,
    required this.rating,
    required this.reviewCount,
    required this.difficulty,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.caloriesPerServing,
    required this.mealType,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      cuisine: json['cuisine'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      difficulty: json['difficulty'] ?? '',
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      cookTimeMinutes: json['cookTimeMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
      caloriesPerServing: json['caloriesPerServing'] ?? 0,
      mealType: List<String>.from(json['mealType'] ?? []),
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'cuisine': cuisine,
      'rating': rating,
      'reviewCount': reviewCount,
      'difficulty': difficulty,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'caloriesPerServing': caloriesPerServing,
      'mealType': mealType,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}