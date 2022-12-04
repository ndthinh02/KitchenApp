import 'package:flutter/material.dart';

class Category {
  String name;
  AssetImage image;
  Category({required this.image, required this.name});
}

List<Category> FAKE_CATEGORY = [
  Category(image: const AssetImage('images/monphu.jpg'), name: "Món phụ"),
  Category(image: const AssetImage('images/monchinh.jpg'), name: "Món chính"),
  Category(image: const AssetImage('images/fruit.jpg'), name: "Trái cây"),
  Category(image: const AssetImage('images/drink.jpg'), name: "Đồ Uống"),
];
