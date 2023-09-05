import 'package:betdelalamobile/widget_file/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/house_product_list.dart';

class SearchResultingScreen extends StatefulWidget {
  static const routeName = '/search-Resulting-screen';
  dynamic isSelecting;
  SearchResultingScreen({required isSelecting});

  @override
  State<SearchResultingScreen> createState() => _SearchResultingScreenState();
}

class _SearchResultingScreenState extends State<SearchResultingScreen> {
  @override
  void dispose() {
    Provider.of<HouseProductList>(context, listen: false)
        .resetSearchResultPage();
    // TODO: implement dispose
    super.dispose();
  }

  final value = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final searchResultItem =
        Provider.of<HouseProductList>(context, listen: false).searchResult;
    print(searchResultItem.length);
    var deviceSize = MediaQuery.of(context).size;
    return searchResultItem.isNotEmpty
        ? SearchResult(searchProducts: searchResultItem)
                                  : Container(
            margin: const EdgeInsets.symmetric(
              vertical: 300,
                                              ),
            child: widget.isSelecting == true
                ? const Text(
                    ' RDRDFD',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                                              maxLines: 1,
                              )
                : const Text(''));
  }
}
