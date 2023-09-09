import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  String? _id;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _id = ModalRoute.of(context)?.settings.arguments as String? ?? null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: _id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(
                    'https://hips.hearstapps.com/hmg-prod/images/delish-202002-pozole-0392-landscape-pf-1582315071.jpg?crop=1xw:0.8441943127962085xh;center,top&resize=1200:*'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          'Rice with chicken',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                            ),
                            Icon(
                              Icons.star_half,
                              color: Colors.amberAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      child: UnconstrainedBox(
                        child: SvgPicture.asset(
                          'assets/icons/hearthIcon.svg',
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'A simple rice recipe is a delicious and versatile dish that can serve as a side or main dish.',
                  style: TextStyle(
                    color: Color(0xff737373),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 6,
                          color: Color(0xffFFBB5C),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Rice',
                          style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 6,
                          color: Color(0xffFFBB5C),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Water',
                          style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 6,
                          color: Color(0xffFFBB5C),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Salt',
                          style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 6,
                          color: Color(0xffFFBB5C),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Oil',
                          style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Instructions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'To prepare this recipe, you cook rice in water or broth until tender and dry. You can customize it by adding ingredients such as vegetables, herbs, spices or proteins, depending on your preferences. Rice can be steamed, boiled, or fried, giving it different textures and flavors.',
                  style: TextStyle(
                    color: Color(0xff737373),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
