import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://hips.hearstapps.com/hmg-prod/images/delish-202002-pozole-0392-landscape-pf-1582315071.jpg?crop=1xw:0.8441943127962085xh;center,top&resize=1200:*'),
                  radius: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Breakfast',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Breakfast is the first meal of the day consumed after waking up, usually in the morning.',
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
