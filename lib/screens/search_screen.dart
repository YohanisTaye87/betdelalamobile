// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:betdelalamobile/widget/search_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_loadouts.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/house-search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void _setSearchDropdowns() async {
    await Provider.of<SearchLoadouts>(context, listen: false)
       .setSearchLoadOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    _setSearchDropdowns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String>? _categoryOptions =
        Provider.of<SearchLoadouts>(context).categoryOptions;
    final List<String>? _contractTypeOptions =
        Provider.of<SearchLoadouts>(context).contractTypeOptions;
    final List<String>? _locationOptions =
        Provider.of<SearchLoadouts>(context).locationOptions;
    final List<String>? _conditionOptions =
        Provider.of<SearchLoadouts>(context).conditionOptions;
    final double? _minPrice = Provider.of<SearchLoadouts>(context).minPrice;
    final double? _maxPrice = Provider.of<SearchLoadouts>(context).maxPrice;
    final int? _minBeds = Provider.of<SearchLoadouts>(context).minBeds;
    final int? _minBaths = Provider.of<SearchLoadouts>(context).minBaths;
    final int? _minGarages = Provider.of<SearchLoadouts>(context).minGarages;
    final int? _maxGarages = Provider.of<SearchLoadouts>(context).maxGarages;
    final int? _maxBeds = Provider.of<SearchLoadouts>(context).maxBeds;
    final int? _maxBaths = Provider.of<SearchLoadouts>(context).maxBaths;
    //dynamic _keywords = Provider.of<SearchLoadouts>(context).keywords;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchForm(
              categoryOptions: _categoryOptions,
              locationOptions: _locationOptions,
              conditionOptions: _conditionOptions,
              contractTypeOptions: _contractTypeOptions,
              minPrice: _minPrice,
              maxPrice: _maxPrice,
              minBeds: _minBeds,
              minBaths: _minBaths,
              minGarages: _minGarages,
              maxBeds: _maxBeds,
              maxGarages: _maxGarages,
              maxBaths: _maxBaths,
              //keywords:_keywords

              // modelsList: _modelsList,
            ),
          ],
        ),
      ),
    );
  }
}
