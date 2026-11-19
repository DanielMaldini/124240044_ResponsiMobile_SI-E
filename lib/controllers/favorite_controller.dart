import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe.dart';

class FavoriteController extends GetxController {
  final RxList<Recipe> favorites = <Recipe>[].obs;
  static const _key = 'favorite_recipes';

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  bool isFavorite(Recipe recipe) => favorites.any((e) => e.id == recipe.id);

  Future<void> toggle(Recipe recipe) async {
    if (isFavorite(recipe)) {
      favorites.removeWhere((e) => e.id == recipe.id);
    } else {
      favorites.add(recipe);
    }
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final data = favorites.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, data);
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getStringList(_key) ?? [];
      favorites.assignAll(data.map((e) => Recipe.fromJson(jsonDecode(e))));
    } catch (_) {
      favorites.clear();
    }
  }
}