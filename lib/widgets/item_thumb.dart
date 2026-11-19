import 'package:flutter/material.dart';

class ItemThumb extends StatelessWidget {
  final String url;
  final double size;
  const ItemThumb({super.key, required this.url, this.size = 64});

  @override
  Widget build(BuildContext context) {
    final fallback = SizedBox(
      width: size,
      height: size,
      child: const Icon(Icons.broken_image, color: Colors.grey),
    );
    if (url.isEmpty) return fallback;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => fallback,
      ),
    );
  }
}