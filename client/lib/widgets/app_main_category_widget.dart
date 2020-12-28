import 'package:flutter/material.dart';

class AppMainCategoryWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback callback;

  AppMainCategoryWidget(
      {@required this.imageUrl, @required this.title, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          child: Image.asset(
            'assets/images/main-categories/${this.imageUrl}',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 15),
        Text(this.title),
        SizedBox(height: 15),
        RaisedButton(
          onPressed: this.callback,
          child: Text('Seç'),
        )
      ],
    );
  }
}
