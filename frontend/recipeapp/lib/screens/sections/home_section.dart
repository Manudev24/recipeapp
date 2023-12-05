import 'package:cookingenial/models/category_model.dart';
import 'package:cookingenial/services/api/category_api.dart';
import 'package:cookingenial/widgets/chief_widget.dart';
import 'package:cookingenial/widgets/homeSection/home_category_widget.dart';
import 'package:cookingenial/widgets/recipe_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  Future<List<CategoryModel>>? _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = CategoryApi.getRandomCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello Victor',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Are you ready for daily recipe?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff737373),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://as2.ftcdn.net/v2/jpg/03/64/21/11/1000_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/searchRecipeScreen'),
            child: Material(
              elevation: 3.0,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffEEEEEE),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      UnconstrainedBox(
                        child: SvgPicture.asset(
                          'assets/icons/magnifyingIcon.svg',
                          colorFilter: const ColorFilter.mode(
                            Color(0xff737373),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Search recipe',
                        style: TextStyle(
                          color: Color(0xff737373),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/categoriesScreen'),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xffE25E3E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<CategoryModel>>(
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
                  return Row(
                    children: [
                      for (var item in snapshot.data!)
                        HomeCategoryWidget(categoryModel: item),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daily recipes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, '/dailyRecipesScreen'),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xffE25E3E),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RecipeWidget(id: "4b3e8cea-b657-4cd5-8a47-34b48c7971bd"),
                  // RecipeWidget(id: "2"),
                  // RecipeWidget(id: "3"),
                  // RecipeWidget(id: "4"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top chiefs',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: Color(0xffE25E3E),
                ),
              ),
            ],
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ChiefWidget(id: "5"),
                ChiefWidget(id: "6"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
