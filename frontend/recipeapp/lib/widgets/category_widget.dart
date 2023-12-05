import 'package:flutter/material.dart';
import 'package:cookingenial/models/category_model.dart';
import 'package:cookingenial/utils/constans.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryWidget({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: GestureDetector(
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
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      '$apiUrl/category/get-image/${categoryModel.id}'),
                  radius: 35,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoryModel.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        categoryModel.description,
                        style: const TextStyle(
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
