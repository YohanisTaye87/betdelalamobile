import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/recommanded_house_provider.dart';
import '../widget_file/cardFunction.dart';

class RecommandedHousesScreen extends StatefulWidget {
  const RecommandedHousesScreen({super.key});

  @override
  State<RecommandedHousesScreen> createState() => _RecommandedHousesScreen();
}

class _RecommandedHousesScreen extends State<RecommandedHousesScreen> {
  @override
  void dispose() {
    Provider.of<RecommandedHouses>(context, listen: false)
        .resetSearchResultPage();
    // TODO: implement dispose
    super.dispose();
  }

  final value = NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    final recommandedHouseResult =
        Provider.of<RecommandedHouses>(context).recommandedItems;
    return recommandedHouseResult.isNotEmpty
        ? CardsFunctions(
            CardProductList: recommandedHouseResult,
            CardTitle: 'Recommanded Houses',
          )
        : const Text('');
  }
}
