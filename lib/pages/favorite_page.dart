import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../widgets/item_thumb.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fav = Get.find<FavoriteController>();
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7E9),
      appBar: AppBar(
        title: const Text('Favorite'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),

      body: Obx(() {
        final list = fav.favorites;
        if (list.isEmpty) {
          return const Center(child: Text('Belum ada resep favorite'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (context, i) {
            final recipe = list[i];
            return Card(
              child: ListTile(
                leading: ItemThumb(url: recipe.image),
                title: Text(recipe.name,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                subtitle: Text('${recipe.cuisine} • ${recipe.difficulty}'),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => fav.toggle(recipe),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(recipeId: recipe.id),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}