import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com/recipes';

  static Future<List<Recipe>> getRecipes() async {
    final response = await http.get(Uri.parse('$baseUrl?limit=0'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['recipes'];
      return list.map((e) => Recipe.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat resep');
    }
  }

  static Future<Recipe> getRecipe(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat detail resep');
    }
  }
}