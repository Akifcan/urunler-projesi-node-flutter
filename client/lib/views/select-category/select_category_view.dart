import 'package:client/data/categories.dart';
import 'package:client/services/product_service.dart';
import 'package:client/widgets/app_main_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCategoryView extends StatelessWidget {
  const SelectCategoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hoşgeldiniz',
                      style: Theme.of(context).textTheme.headline4),
                  Text(
                    'Alışverinizin türünü seçin',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppMainCategoryWidget(
                          imageUrl: 'market.png',
                          title: 'Market Alışverişi',
                          callback: () {
                            Provider.of<ProductService>(context, listen: false)
                                .setCategory(marketCategories, 'search-market');
                            Navigator.of(context).pushNamed('/home');
                          }),
                      AppMainCategoryWidget(
                          imageUrl: 'store.png',
                          title: 'Mağaza Alışverişi',
                          callback: () {
                            Provider.of<ProductService>(context, listen: false)
                                .setCategory(storeCategories, 'search-product');
                            Navigator.of(context).pushNamed('/home');
                          }),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
