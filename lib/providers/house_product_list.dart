// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:betdelalamobile/model/house_list_model.dart';
import 'package:betdelalamobile/model/Products.dart';

//import 'package:betdelalamobile/model/property_recommanded_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/http_exception.dart';

class HouseProductList extends ChangeNotifier {
  List<Content> searchResult = [];
  List<Content> featuredItem = [];
  List<Content> Products = [];
  final List<Product> _items = [];
  ScrollController scrollController = ScrollController();

  // Future<List<PropertyListModel>>? houseProductList;
  bool isLoadMoreRunning = false,
      isLoadMoreRunningA = false,
      hasNextPage = true,
      hasNextPageA = true;
  int page = 0;

  var _searchData;
  int _pageNumber = 0;
  
  

  

  Future<void>? searchHousesList(Map<String, dynamic> searchData) async {
    if (_pageNumber == 0) {
      searchResult = [];
      _searchData = searchData;
    }
    //_searchData = searchData;

    Uri Url = Uri.parse(
        "https://sea-turtle-app-j4ksa.ondigitalocean.app/public/search?page=$page&size=18&sort=publishedTime,DESC");
    try {
      final jsonBody = json.encode(
        {
          "pagination": {
            "page": 0,
            "size": 10,
          },
          "location": _searchData["locationOptions"],
          "contractType": _searchData["contractTypeOptions"],
          "propertyCategory": _searchData["categoryOptions"],
          "propertyCondition": _searchData["conditionOptions"],
          "keyWord": _searchData["keyWords"],
          "minBeds": _searchData["minBeds"],
          "maxBeds": _searchData["maxBeds"],
          "minBaths": _searchData["minBaths"],
          "maxBaths": _searchData["maxBaths"],
          "minGarages": _searchData["minGarages"],
          "maxGarages": _searchData["maxGarages"],
          "minPrice": _searchData["minPrice"],
          "maxPrice": _searchData["maxPrice"],
          "minYear": _searchData["minYear"],
          "maxYear": _searchData["maxYear"],
          "approvedStatus": "APPROVED"
        },
      );
      final resposne = await http.post(
        Url,
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // print(resposne.body);
      var jsonResponseData = json.decode(resposne.body);
      //print(jsonResponseData['content']);
      List<Content> SearchedHouseList = [];
      for (var x in jsonResponseData['content']) {
        SearchedHouseList.add(Content(
          id: x["id"] ?? 0,
          publicId: x["publicId"] ?? "",
          title: x["title"] ?? "",
          description: x["description"] ?? "",
          propertyImagesList: x["propertyImagesList"] == null
              ? []
              : List<PropertyImagesList>.from(x["propertyImagesList"]!
                  .map((x) => PropertyImagesList.fromJson(x))),
          addressLookups: x["addressLookups"] == null
              ? null
              : AddressLookups.fromJson(x["addressLookups"]),
          latitude: x["latitude"] ?? "",
          longitude: x["longitude"] ?? "",
          enumContractType: x["enumContractType"] ?? "",
          enumCurrencyType: x["enumCurrencyType"] ?? "",
          approvedStatus: x["approvedStatus"] ?? "",
          price: x["price"] ?? 0,
          bedrooms: x["bedrooms"] ?? 0,
          bathrooms: x["bathrooms"] ?? 0,
          area: x["area"] ?? 0,
          publishedTime: x["publishedTime"] == null
              ? null
              : DateTime.parse(x["publishedTime"]),
          //impression: x["impression"] ?? 0,
        ));
      }
      searchResult.addAll(SearchedHouseList);
    } catch (error) {
      print("This is my error :$error ");
    }
  }

  void resetSearchResultPage() async {
    _pageNumber = 0;
    searchResult = [];
    notifyListeners();
  }

  Future<void> getFeaturedHouseList() async {
    featuredItem = [];
    try {
      var uri =
          // ignore: prefer_adjacent_string_concatenation
          'https://sea-turtle-app-j4ksa.ondigitalocean.app/public/property/featured';
      //final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List<dynamic>;

        // print('This is jonaz file:${jsonResponse.length}');
        // print('This is jonaz file:${jsonResponse}');
        List<Content> featuredHouse = [];
        for (var x in jsonResponse) {
          featuredHouse.add(Content(
            id: x["id"] ?? 0,
            publicId: x["publicId"] ?? "",
            title: x["title"] ?? "",
            description: x["description"] ?? "",
            propertyImagesList: x["propertyImagesList"] == null
                ? []
                : List<PropertyImagesList>.from(x["propertyImagesList"]!
                    .map((x) => PropertyImagesList.fromJson(x))) as dynamic,
            addressLookups: x["addressLookups"] == null
                ? null
                : AddressLookups.fromJson(x["addressLookups"]),
            latitude: x["latitude"] ?? "",
            longitude: x["longitude"] ?? "",
            enumContractType: x["enumContractType"] ?? "",
            enumCurrencyType: x["enumCurrencyType"] ?? "",
            approvedStatus: x["approvedStatus"] ?? "",
            price: x["price"] ?? 0,
            bedrooms: x["bedrooms"] ?? 0,
            bathrooms: x["bathrooms"] ?? 0,
            area: x["area"] ?? 0,
            publishedTime: x["publishedTime"] == null
                ? null
                : DateTime.parse(x["publishedTime"]),
            //impression: x["impression"] ?? 0,
          ));
        }
        featuredItem.addAll(featuredHouse);
        notifyListeners();
      } else {
        print(response.statusCode);
        print('The status code error :invalid response recived');
      }
    } catch (error) {
      print('This is an error :$error');
    }
    return;
  }

  void resetFeaturedList() async {
    featuredItem = [];
    notifyListeners();
  }

  void dialogue(String message) {
    // AwesomeDialog(
    //   context: context,
    //   animType: AnimType.TOPSLIDE,
    //   headerAnimationLoop: false,
    //   dialogType: DialogType.success,
    //   showCloseIcon: true,
    //   title: 'Registration sucess!',
    //   desc: message,
    //   btnOkOnPress: () {
    //     // Navigator.of(context).pop();
    //   },
    //   btnOkIcon: Icons.check_circle,
    //   btnOkText: 'Ok',
    //   btnCancelOnPress: () {},
    //   btnCancelIcon: Icons.cancel,
    //   onDismissCallback: (type) {
    //     print('Dialog Dissmiss from callback $type');
    //   },
    // ).show();
  }
}
