import 'package:flutter/material.dart';

Widget getStarsQuantity(double quantity) {
  int fullStars = quantity.floor();
  bool hasHalfStar = (quantity - fullStars) >= 0.5;

  List<Widget> stars = List<Widget>.generate(
    fullStars,
    (index) => const Icon(Icons.star, color: Colors.orange),
  );

  if (hasHalfStar) {
    stars.add(const Icon(Icons.star_half, color: Colors.orange));
  }

  return Row(children: stars);
}
