// ignore_for_file: deprecated_member_use, use_build_context_synchronously, prefer_const_constructors

import 'package:betdelalamobile/providers/house_product_list.dart';
import 'package:betdelalamobile/screens/map_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../screens/search_Resulting_screen.dart';

import 'drop_down.dart';

class SearchForm extends StatefulWidget {
  final List<String>? categoryOptions;
  final List<String>? locationOptions;
  final List<String>? conditionOptions;
  final List<String>? contractTypeOptions;
  final double? minPrice;
  final double? maxPrice;
  final int? minBeds;
  final int? minBaths;
  final int? minGarages;
  final int? maxBeds;
  final int? maxBaths;
  final int? maxGarages;
  dynamic keywords;

  SearchForm(
      {required this.categoryOptions,
      required this.locationOptions,
      required this.conditionOptions,
      required this.contractTypeOptions,
      required this.minPrice,
      required this.maxPrice,
      required this.minBeds,
      required this.minBaths,
      required this.minGarages,
      required this.maxBeds,
      required this.maxBaths,
      required this.maxGarages});
  @override
  _SearchFormState createState() => _SearchFormState();
}

Map<String, dynamic> _searchData = {
  "categoryOptions": null,
  "contractTypeOptions": null,
  "conditionOptions": null,
  "locationOptions": null,
  "minPrice": null,
  "maxPrice": null,
  "maxGarages": null,
  "maxBaths": null,
  "maxBeds": null,
  "minBeds": null,
  "minBaths": null,
  "minGarages": null,
  "minYear": null,
  "maxYear": null,
  "keywords": null,
};

void setminYear(String minYear) {
  _searchData['minYear'] = minYear;
}

void setmaxYear(String maxYear) {
  _searchData['maxYear'] = maxYear;
}

void setcategoryOptions(String categoryOptions) {
  _searchData['categoryOptions'] = categoryOptions;
}

void setLocationOption(String locationOptions) {
  _searchData['locationOptions'] = locationOptions;
}

void setcontractTypeOption(String contractTypeOptions) {
  _searchData['contractTypeOptions'] = contractTypeOptions;
}

void setconditionOptions(String conditionOptions) {
  _searchData['conditionOptions'] = conditionOptions;
}

List<String> years = [];
void _setYears() {
  years = [];
  for (int i = DateTime.now().year; i > DateTime.now().year - 50; i--) {
    years.add(i.toString());
  }
}

class _SearchFormState extends State<SearchForm> {
  var isSelected = false;
  final value = NumberFormat("#,##0.00",
      "en_US"); // a variables used to format a number in correct format
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var _searchLess = false;

  Future<void> _filterAndSearch(isSelected) async {
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    setState(() {});
    await Provider.of<HouseProductList>(context, listen: false)
        .searchHousesList(
      _searchData,
    );

    setState(() {});
    _resetValues();
    SearchResultingScreen(
      isSelecting: isSelected,
    );
  }

  Future<void> _filterAndSearchMap() async {
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    setState(() {});
    await Provider.of<HouseProductList>(context, listen: false)
        .searchHousesList(
      _searchData,
    );
    _resetValues();
    Navigator.of(context).pushNamed(MapScreen.routeName);
  }

  void _resetValues() {
    _searchData['categoryOptions'] = null;
    _searchData['contractTypeOptions'] = null;
    _searchData['conditionOptions'] = null;
    _searchData['locationOptions'] = null;
    _searchData['minPrice'] = null;
    _searchData['maxPrice'] = null;
    _searchData['priceType'] = null;
    _searchData['minMileage'] = null;
    _searchData['maxMileage'] = null;
    _searchData['minYear'] = null;
    _searchData['maxYear'] = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_formkey.currentState != null) _formkey.currentState!.dispose();
    _resetValues();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _setYears();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    _searchData['maxGarages'] = widget.maxGarages;
    _searchData['maxBaths'] = widget.maxBaths;
    _searchData['maxBeds'] = widget.maxBeds;

    return Column(
      children: [
        Container(
          //height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          //margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            //border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(top: 15),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.location_on),
                    label: const Text(
                      'Map Search',
                      style: TextStyle(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    //style: ButtonStyle(shape: (),padding: EdgeInsets.all(2)),
                    onPressed: () {
                      _filterAndSearchMap();
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 2,
                  ),
                ),
                Container(
                    height: deviceSize.height * 0.06,
                    //height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black, width: 1),
                            bottom: BorderSide(color: Colors.black, width: 1))),
                    child: DropDown('Location', widget.locationOptions, false,
                        false, false)),
                _searchLess
                    ? Container(
                        height: deviceSize.height * 0.06,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1))),
                        child: DropDown('Type', widget.conditionOptions, false,
                            false, false))
                    : Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: Colors.black, width: 1),
                                        left: BorderSide(
                                            color: Colors.black, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1))),
                                child: DropDown('Type', widget.conditionOptions,
                                    false, false, false)),
                          ),
                          Expanded(
                            child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1),
                                        right: BorderSide(
                                            color: Colors.black, width: 1))),
                                child: DropDown(
                                    'Category',
                                    widget.categoryOptions,
                                    false,
                                    false,
                                    false)),
                          ),
                        ],
                      ),
                if (_searchLess)
                  Container(
                      height: deviceSize.height * 0.06,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 1))),
                      child: DropDown('Category', widget.categoryOptions, false,
                          false, false)),
                if (_searchLess)
                  Container(
                      height: deviceSize.height * 0.06,
                      //height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 1))),
                      child: DropDown('Condition', widget.contractTypeOptions,
                          false, false, false)),
                if (_searchLess)
                  Container(
                    child: TextFormField(
                      validator: (val) {
                        if (val.toString().isNotEmpty) {
                          if (!RegExp(r"^[0-9]").hasMatch(val.toString())) {
                            return 'invalid entry';
                          }
                          //print('INC ');

                          return null;
                        }
                        return null;
                      },
                      onSaved: (minPrice) {
                        _searchData['minPrice'] =
                            double.parse(minPrice.toString());
                      },
                      controller:
                          TextEditingController(text: (('${widget.minPrice}'))),
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                          // hintText: "${widget.minPrice}",
                          label: Text(
                            'Min price',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          )),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                if (_searchLess)
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.9,
                    // ignore: prefer_const_constructors
                    child: TextFormField(
                      onSaved: (maxPrice) {
                        _searchData['maxPrice'] =
                            double.parse(maxPrice.toString());
                      },
                      autofocus: true,
                      controller:
                          TextEditingController(text: (('${widget.maxPrice}'))),
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 18,
                          ),
                          label: Text(
                            'Max price',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          )),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                if (_searchLess)
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      onSaved: (minBeds) {
                        _searchData['minBeds'] = int.parse(minBeds.toString());
                      },
                      controller:
                          TextEditingController(text: "${widget.minBeds}"),
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          label: Text(
                            'Min Beds',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          )),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                if (_searchLess)
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      onSaved: (minBaths) {
                        _searchData['minBaths'] =
                            int.parse(minBaths.toString());
                      },
                      controller:
                          TextEditingController(text: "${widget.minBaths}"),
                      style: const TextStyle(fontSize: 18),
                      autofocus: true,
                      decoration: const InputDecoration(
                        label: Text(
                          'Max Bath',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                if (_searchLess)
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                        autofocus: true,
                        onSaved: (mingarage) {
                          _searchData['mingarage'] =
                              int.parse(mingarage.toString());
                        },
                        controller:
                            TextEditingController(text: "${widget.minGarages}"),
                        style: const TextStyle(fontSize: 18),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text(
                            'Min Garages',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        )),
                  ),
                if (_searchLess)
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black,
                                                width: 1))),
                                    child: DropDown('Min Year', years, false,
                                        false, false)),
                              ),
                            ]),
                      ),
                      Expanded(
                        child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 1),
                                    left: BorderSide(
                                        color: Colors.black, width: 1))),
                            child: DropDown(
                                'Max Year', years, false, false, false)),
                      ),
                    ],
                  ),
                if (_searchLess)
                  Container(
                    child: TextFormField(
                      autofocus: true,
                      style: const TextStyle(fontSize: 18),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text(
                          'Keyords',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: deviceSize.height * 0.02),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: deviceSize.height * 0.06,
                          width: deviceSize.width * 0.43,
                          padding: EdgeInsets.only(right: 15),
                          child: _searchLess
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.teal.shade600,
                                      shape: const StadiumBorder()),
                                  //color: Colors.teal.shade600,
                                  onPressed: () {
                                    setState(() {
                                      _searchLess = !_searchLess;
                                      setState(() {
                                        isSelected == true;
                                      });
                                      _filterAndSearch(isSelected);
                                    });
                                  },
                                  // textColor: Colors.white,
                                  child: const Text(
                                    'Search',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.teal.shade600,
                                      shape: const StadiumBorder()),
                                  onPressed: () {
                                    // Navigator.of(context)
                                    //     .pushNamed(ProductGrid.routeName);
                                    setState(() {
                                      isSelected == true;
                                    });

                                    _filterAndSearch(isSelected);
                                  },
                                  child: const Text(
                                    'Search',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                      Container(
                          height: deviceSize.height * 0.06,
                          width: deviceSize.width * 0.43,
                          padding: EdgeInsets.only(left: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.teal.shade600,
                                shape: const StadiumBorder()),
                            onPressed: () {
                              setState(() {
                                _searchLess = !_searchLess;
                              });
                            },
                            child: _searchLess
                                ? const Text(
                                    'Less Filter',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(
                                    'More Filter',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                          )),
                    ],
                  ),
                ),
                _searchLess
                    ? SizedBox(height: deviceSize.height * 0.2)
                    : SizedBox(
                        height: 5,
                      ),
                _searchLess
                    ? SizedBox(
                        height: deviceSize.height * 0.06,
                      )
                    : SizedBox(
                        child: SearchResultingScreen(
                        isSelecting: isSelected,
                      ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
