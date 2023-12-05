import 'package:cookingenial/utils/constans.dart';
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
      width: 200,
      padding: const EdgeInsets.only(right: 10),
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
                          '${apiUrl}/recipe/get-image/${widget.id}'),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover
                      // fit: BoxFit.cover,
                      ),
                ),
              ),
            ),
            const Text(
              'Rice with chicken',
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const Row(
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
