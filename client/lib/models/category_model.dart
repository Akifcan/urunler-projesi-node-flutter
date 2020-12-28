import 'package:flutter/material.dart';

class CategoryModel {
  final String categoryName;
  final String categoryImage;
  final String keyword;

  CategoryModel(
      {@required this.categoryImage,
      @required this.categoryName,
      @required this.keyword});
}
