import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipeapp/widgets/chief_widget.dart';
import 'package:recipeapp/widgets/recipe_widget.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
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
          SizedBox(
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
                  color: Color(0xffEEEEEE),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      UnconstrainedBox(
                        child: SvgPicture.asset(
                          'assets/icons/magnifyingIcon.svg',
                          colorFilter: ColorFilter.mode(
                            Color(0xff737373),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
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
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
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
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://images.immediate.co.uk/production/volatile/sites/30/2023/03/Big-batch-lamb-stew-e62ace3.jpg?quality=90&webp=true&resize=600,545'),
                        ),
                        Text('Breakfast')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://images.immediate.co.uk/production/volatile/sites/30/2023/03/Big-batch-lamb-stew-e62ace3.jpg?quality=90&webp=true&resize=600,545'),
                        ),
                        Text('Breakfast')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://images.immediate.co.uk/production/volatile/sites/30/2023/03/Big-batch-lamb-stew-e62ace3.jpg?quality=90&webp=true&resize=600,545'),
                        ),
                        Text('Breakfast')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://images.immediate.co.uk/production/volatile/sites/30/2023/03/Big-batch-lamb-stew-e62ace3.jpg?quality=90&webp=true&resize=600,545'),
                        ),
                        Text('Breakfast')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://images.immediate.co.uk/production/volatile/sites/30/2023/03/Big-batch-lamb-stew-e62ace3.jpg?quality=90&webp=true&resize=600,545'),
                        ),
                        Text('Breakfast')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://images.immediate.co.uk/production/volatile/sites/30/2023/03/Big-batch-lamb-stew-e62ace3.jpg?quality=90&webp=true&resize=600,545'),
                        ),
                        Text('Breakfast')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily recipes',
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                RecipeWidget(id: "1"),
                RecipeWidget(id: "2"),
                RecipeWidget(id: "3"),
                RecipeWidget(id: "4"),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
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
          SingleChildScrollView(
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
