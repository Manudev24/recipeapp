import 'package:flutter/material.dart';
import 'package:cookingenial/models/category_model.dart';
import 'package:cookingenial/services/api/category_api.dart';
import 'package:cookingenial/widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Future<List<CategoryModel>>? _futureCategories;
  @override
  void initState() {
    super.initState();
    _futureCategories = CategoryApi.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        surfaceTintColor: Colors.transparent,
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      Text("")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      Text("")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      Text("")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      Text("")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      Text("")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      Text("")
                    ],
                  ),
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text('Error to get the categories'),
            );
          }
          if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
            return const Center(
              child: Text('Categories no found'),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                for (var item in snapshot.data!)
                  CategoryWidget(categoryModel: item),
              ],
            ),
          );
        },
      ),
    );
  }
}
