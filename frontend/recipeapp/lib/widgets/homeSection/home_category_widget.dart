import 'package:cookingenial/models/category_model.dart';
import 'package:flutter/material.dart';

class HomeCategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  const HomeCategoryWidget({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: SizedBox(
        width: 65,
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              //TODO: ADD URL
              backgroundImage: AssetImage('assets/images/splash/logo.png'),
              // backgroundImage: NetworkImage(
              //     '$apiUrl/category/get-image/${categoryModel.id}'),
            ),
            Text(
              categoryModel.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            )
          ],
        ),
      ),
    );
  }
}
