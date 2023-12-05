import 'package:cookingenial/models/recipe_model.dart';
import 'package:cookingenial/utils/constans.dart';
import 'package:flutter/material.dart';

class SearchItemWidget extends StatefulWidget {
  final RecipeModel recipeModel;
  const SearchItemWidget({super.key, required this.recipeModel});

  @override
  State<SearchItemWidget> createState() => _SearchItemWidgetState();
}

class _SearchItemWidgetState extends State<SearchItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      padding: const EdgeInsets.only(right: 10),
      // color: Colors.grey,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          '/recipeScreen',
          arguments: widget.recipeModel.id,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: widget.recipeModel.id,
                  child: Image(
                    image: NetworkImage(
                        '$apiUrl/recipe/get-image/${widget.recipeModel.id}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              widget.recipeModel.name,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              widget.recipeModel.qualification!.toStringAsFixed(1),
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            // Row(
            //   children: [
            //     Icon(
            //       Icons.star,
            //       color: Colors.amberAccent,
            //     ),
            //     Icon(
            //       Icons.star,
            //       color: Colors.amberAccent,
            //     ),
            //     Icon(
            //       Icons.star,
            //       color: Colors.amberAccent,
            //     ),
            //     Icon(
            //       Icons.star,
            //       color: Colors.amberAccent,
            //     ),
            //     Icon(
            //       Icons.star_half,
            //       color: Colors.amberAccent,
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
