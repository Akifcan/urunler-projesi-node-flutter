import 'package:client/models/product_model.dart';
import 'package:flutter/material.dart';

class AppProductWidget extends StatelessWidget {
  final ProductModel product;

  AppProductWidget({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child:
                  Image.network(this.product.productImage, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(this.product.productName,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${this.product.productPrice.toStringAsFixed(4)}₺',
                      style: Theme.of(context).textTheme.subtitle1),
                  Text(this.product.brand,
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              )),
          Align(
            alignment: Alignment.center,
            child: RaisedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.shopping_bag),
                label: Text('Detaylar')),
          )
        ],
      ),
    );
  }
}
