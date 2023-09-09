import 'package:flutter/material.dart';

class RecipeWidget extends StatefulWidget {
  final String id;
  const RecipeWidget({super.key, required this.id});

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      padding: EdgeInsets.only(right: 10),
      // color: Colors.grey,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          '/recipeScreen',
          arguments: widget.id,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: widget.id,
                  child: Image(
                    image: NetworkImage(
                        'https://hips.hearstapps.com/hmg-prod/images/delish-202002-pozole-0392-landscape-pf-1582315071.jpg?crop=1xw:0.8441943127962085xh;center,top&resize=1200:*'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              'Rice with chicken',
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                fontSize: 15,
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
            )
          ],
        ),
      ),
    );
  }
}
