//import 'package:betdelalamobile/providers/houses.dart';
//import 'package:betdelalamobile/providers/products_screen.dart';
import 'package:betdelalamobile/widget/product_grid.dart';
import 'package:flutter/material.dart';

//import 'screens/detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyShop',
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(secondary: Colors.deepOrange),
      ),
      home: const ProductGrid(),
      routes: const {
        // DetailScreen.routename: ((context) => DetailScreen()),
      },
    );
  }
}
