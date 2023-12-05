import 'package:flutter/material.dart';
import 'package:cookingenial/widgets/favorite_widget.dart';

class DailyRecipesScreen extends StatefulWidget {
  const DailyRecipesScreen({super.key});

  @override
  State<DailyRecipesScreen> createState() => _DailyRecipesScreenState();
}

class _DailyRecipesScreenState extends State<DailyRecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily recipes'),
      ),
      body: const Column(
        children: [
          FavoriteWidget(
            id: "10",
          ),
          FavoriteWidget(
            id: "11",
          ),
        ],
      ),
    );
  }
}
