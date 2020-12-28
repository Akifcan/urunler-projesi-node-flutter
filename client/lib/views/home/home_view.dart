import 'package:client/services/product_service.dart';
import 'package:client/widgets/app_category_widget.dart';
import 'package:client/widgets/app_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController textEditingController = TextEditingController();

  searchProduct() {
    Provider.of<ProductService>(context, listen: false)
        .searchProduct(textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appTitle(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _appCategories(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              _appSearch(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Expanded(child: Consumer<ProductService>(
                builder: (context, model, child) {
                  return model.products.length == 0
                      ? Text('Henüz ürün aramadınız',
                          style: Theme.of(context).textTheme.headline3)
                      : GridView.builder(
                          itemCount: model.products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1 / 1.5,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) =>
                              AppProductWidget(product: model.products[index]));
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _appTitle(context) => Text(
        'Ürünler',
        style: Theme.of(context).textTheme.headline3,
      );

  Widget _appCategories(context) =>
      Consumer<ProductService>(builder: (context, model, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: ListView.separated(
              itemCount: model.currentCategory.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemBuilder: (context, index) => AppCategoryWidget(
                  categoryModel: model.currentCategory[index])),
        );
      });

  Widget _appSearch(context) => TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: 'Ürününzü buradan arayın',
            filled: true,
            suffixIcon: IconButton(
              color: Colors.black,
              icon: Icon(Icons.search),
              onPressed: searchProduct,
            )),
      );
}
