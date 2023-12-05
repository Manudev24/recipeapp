import 'package:flutter/material.dart';

class FavoriteWidget extends StatelessWidget {
  final String id;
  const FavoriteWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          '/recipeScreen',
          arguments: id,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Row(
              children: [
                Hero(
                  tag: id,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://hips.hearstapps.com/hmg-prod/images/delish-202002-pozole-0392-landscape-pf-1582315071.jpg?crop=1xw:0.8441943127962085xh;center,top&resize=1200:*'),
                    radius: 35,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rice with Chicken',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'A simple rice recipe is a delicious and versatile dish that can serve as a side or main dish.',
                        style: TextStyle(
                          color: Color(0xff737373),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
