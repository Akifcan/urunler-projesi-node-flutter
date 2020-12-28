import 'package:client/models/category_model.dart';
import 'package:client/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppCategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;

  AppCategoryWidget({@required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(this.categoryModel.keyword);
        Provider.of<ProductService>(context, listen: false)
            .searchProduct(this.categoryModel.keyword);
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset(categoryModel.categoryImage),
            radius: 30,
          ),
          Text(categoryModel.categoryName,
              style: Theme.of(context).textTheme.subtitle1)
        ],
      ),
    );
  }
}
