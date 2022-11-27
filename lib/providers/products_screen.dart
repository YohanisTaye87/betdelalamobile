import 'package:flutter/material.dart';

import '../widget/product_grid.dart';



class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductGrid(),
    );
  }
}
