
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/house_product_list.dart';
import '../widget_file/cardFunction.dart';

class FeaturedProduct extends StatefulWidget {
  const FeaturedProduct({super.key});

  @override
  State<FeaturedProduct> createState() => _FeaturedProductState();
}

class _FeaturedProductState extends State<FeaturedProduct> {
  @override
  void dispose() {
    Provider.of<HouseProductList>(context, listen: false).resetFeaturedList();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final featuredProductList =
        Provider.of<HouseProductList>(context).featuredItem;

    return featuredProductList.isNotEmpty
        ? CardsFunctions(
            CardProductList: featuredProductList,
            CardTitle: 'Featured Houses',
              )
        : const Text('');
  }
}
