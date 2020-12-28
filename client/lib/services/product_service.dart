import 'dart:convert';

import 'package:client/models/category_model.dart';
import 'package:client/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  List<CategoryModel> currentCategory = List<CategoryModel>();
  List<ProductModel> products = List<ProductModel>();

  final String api = 'http://192.168.1.6:3000';
  String apiEndPoint = '';

  searchProduct(String keyword) async {
    print(keyword);
    print('$api/$apiEndPoint/$keyword');
    var response = await http.get('$api/$apiEndPoint/$keyword');
    List data = json.decode(response.body);
    this.products = data.map((e) => ProductModel.fromJson(e)).toList();
    print(this.products[0].productName);
    notifyListeners();
  }

  setCategory(List<CategoryModel> category, String endPoint) {
    this.currentCategory = category;
    this.apiEndPoint = endPoint;
  }
}
