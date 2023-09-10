import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/category_widget.dart';
import 'package:recipeapp/widgets/favorite_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Column(
        children: [
          CategoryWidget(),
          CategoryWidget(),
        ],
      ),
    );
  }
}
