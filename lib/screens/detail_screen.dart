// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/houses.dart';
import '../widget/product_detail.dart';

class DetailScreen extends StatelessWidget {
  static final routename = 'routes';
  const DetailScreen({super.key});
  Widget buildContainer(Widget child) {
    return Container(
      alignment: Alignment.centerLeft,
     margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.fromLTRB(20,0,0,0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSectionTitle(BuildContext context, String text) {
      return Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
  
    final abc = ModalRoute.of(context)!.settings().arguments;
    final userElement =
        Provider.of<Houses>(context, listen: false).findById(abc as dynamic);
        
    return Scaffold(
      body: ProductDetail()
    );
  }
}
