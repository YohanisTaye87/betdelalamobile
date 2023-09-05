import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/house_list_model.dart';
//import '../model/recommanded_list_model.dart';

class RecommandedHouses with ChangeNotifier {
  List<Content> recommandedItems = [];
  Future<void> getRecommandedData(String id) async {
    recommandedItems = [];
    try {
      var uri =
          // ignore: prefer_adjacent_string_concatenation
          'https://sea-turtle-app-j4ksa.ondigitalocean.app/public/recommended-properties?categoryId=1&limitSize=6&id=$id';
      //final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List<dynamic>;
        // print('This is jonaz file:${id}');
        // print('This is jonaz file:${jsonResponse.length}');
        // print('This is jonaz file:${jsonResponse}');
        List<Content> loadedHouse = [];
        for (var x in jsonResponse) {
          loadedHouse.add(Content(
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
          ));
        }
        recommandedItems.addAll(loadedHouse);
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

  void resetSearchResultPage() async {
    recommandedItems = [];

    notifyListeners();
  }
}
