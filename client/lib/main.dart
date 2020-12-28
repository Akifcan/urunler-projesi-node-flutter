import 'package:client/services/product_service.dart';
import 'package:client/styles/custom_theme.dart';
import 'package:client/views/home/home_view.dart';
import 'package:client/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProductService(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ürünler',
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      routes: {'/home': (context) => HomeView()},
    );
  }
}
