import 'package:flutter/material.dart';
import 'package:cookingenial/widgets/favorite_widget.dart';

class FavoritesSection extends StatefulWidget {
  const FavoritesSection({super.key});

  @override
  State<FavoritesSection> createState() => _FavoritesSectionState();
}

class _FavoritesSectionState extends State<FavoritesSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const Column(
        children: [
          FavoriteWidget(
            id: '10',
          ),
          FavoriteWidget(
            id: '10',
          ),
        ],
      ),
    );
  }
}
