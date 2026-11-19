import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class DetailPage extends StatefulWidget {
  final int recipeId;
  const DetailPage({super.key, required this.recipeId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Recipe> _future;
  final fav = Get.find<FavoriteController>();

  @override
  void initState() {
    super.initState();
    _future = ApiService.getRecipe(widget.recipeId);
  }

  Future<void> _toggleFavorite(Recipe recipe) async {
    final wasFav = fav.isFavorite(recipe);
    await fav.toggle(recipe);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content:
            Text(wasFav ? 'Dihapus dari favorite' : 'Ditambahkan ke favorite'),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Recipe>(
      future: _future,
      builder: (context, snap) {
        final recipe = snap.data;
        return Scaffold(
          backgroundColor: const Color(0xFFEFF7E9),
          appBar: AppBar(
            title: const Text('Detail Resep'),
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            actions: [
              if (recipe != null)
                Obx(() => IconButton(
                      tooltip: 'Favorite',
                      icon: Icon(
                        fav.isFavorite(recipe)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: fav.isFavorite(recipe)
                            ? Colors.red
                            : Colors.white,
                      ),
                      onPressed: () => _toggleFavorite(recipe),
                    )),
            ],
          ),
          body: _buildBody(snap, recipe),
        );
      },
    );
  }

  Widget _buildBody(AsyncSnapshot<Recipe> snap, Recipe? recipe) {
    if (snap.connectionState != ConnectionState.done) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snap.hasError || recipe == null) {
      return Center(child: Text('Gagal memuat detail: ${snap.error}'));
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            recipe.image,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('${recipe.cuisine} • ${recipe.mealType.join(', ')}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _info(Icons.star, '${recipe.rating} (${recipe.reviewCount})'),
                    _info(Icons.speed, recipe.difficulty),
                    _info(Icons.timer, 'Persiapan ${recipe.prepTimeMinutes} mnt'),
                    _info(Icons.local_fire_department,
                        'Masak ${recipe.cookTimeMinutes} mnt'),
                    _info(Icons.people, '${recipe.servings} porsi'),
                    _info(Icons.bolt, '${recipe.caloriesPerServing} kal/porsi'),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Bahan-bahan',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...recipe.ingredients.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text('• $e'),
                    )),
                const SizedBox(height: 20),
                const Text('Langkah Memasak',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...List.generate(
                  recipe.instructions.length,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.pinkAccent,
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(recipe.instructions[i])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.pinkAccent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.pinkAccent),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}