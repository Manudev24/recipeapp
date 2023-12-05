import 'package:flutter/material.dart';
import 'package:cookingenial/widgets/recipe_widget.dart';

class ChiefScreen extends StatefulWidget {
  const ChiefScreen({super.key});

  @override
  State<ChiefScreen> createState() => _ChiefScreenState();
}

class _ChiefScreenState extends State<ChiefScreen> {
  String? _id;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _id = ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chief'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: _id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1576237680582-75be01432ca6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Juan Martinez',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'A renowned chef of Italian origin, known for his ability to transform simple ingredients into extraordinary dishes.',
                  style: TextStyle(
                    color: Color(0xff737373),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Recipes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      RecipeWidget(id: '1'),
                      RecipeWidget(id: '2'),
                      RecipeWidget(id: '3'),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
