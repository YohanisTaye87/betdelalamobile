import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/house_detail.dart';

class SearchLoadouts with ChangeNotifier {
  // List<String>? get makeList {
  //   print('makeList');
  //   print((_makeList != null));
  //   return (_makeList != null) ? ([..._makeList!]) : null;
  // }

  List<String>? get conditionOptions {
    print('modelsList');
    return (_conditionOptions != null) ? ([..._conditionOptions!]) : null;
  }

  List<String>? get contractTypeOptions {
    return _contractTypeOptions != null ? ([..._contractTypeOptions!]) : null;
  }

  double? get minPrice {
    //to be changed later
    return _minPrice;
  }

  int? get minGarages {
    //to be changed later
    return _minGarages;
  }

  int? get minBeds {
    //to be changed later
    return _minBeds;
  }

  dynamic? get keywords {
    //to be changed later
    return _keywords;
  }

  int? get minBaths {
    //to be changed later
    return _minBaths;
  }

  double? get maxPrice {
    //to be changed later
    return _maxPrice;
  }

  List<String>? get locationOptions {
    return _locationOptions != null ? ([..._locationOptions!]) : null;
  }

  List<String>? get categoryOptions {
    return _categoryOptions != null ? ([..._categoryOptions!]) : null;
  }

  Map<String, dynamic> _extractedDropData = {};
  double? _minPrice, _maxPrice;
  int? _minBeds, _minBaths, _minGarages, maxBeds, maxGarages, maxBaths;
  dynamic _keywords;

  List<String>? _categoryOptions,
      _contractTypeOptions,
      _locationOptions,
      _conditionOptions;
  Future<void> setSearchLoadOut() async {
    _categoryOptions = [];
    _contractTypeOptions = [];
    _locationOptions = [];
    _conditionOptions = [];

    final url = Uri.parse(
        'https://sea-turtle-app-j4ksa.ondigitalocean.app/public/property-search-options');

    try {
      final response = await http.get(url);
      final decodedResponse =
          await json.decode(response.body) as Map<String, dynamic>;
      _extractedDropData = decodedResponse;

      // print([..._extractedDropData['categoryOptions']]);

      // print(_extractedDropData['minBeds']);

      // print(_extractedDropData['minGarages']);

      // print(_extractedDropData['keywords']);

      _keywords = _extractedDropData['keywords'];

      if (_extractedDropData['minPrice'] != null) {
        _minPrice = _extractedDropData['minPrice'];
      }
      if (_extractedDropData['maxPrice'] != null) {
        _maxPrice = _extractedDropData['maxPrice'];
      }
      if (_extractedDropData['minBeds'] != null) {
        _minBeds = _extractedDropData['minBeds'];
      }
      if (_extractedDropData['minBaths'] != null) {
        _minBaths = _extractedDropData['minBaths'];
      }
      if (_extractedDropData['minGarages'] != null) {
        _minGarages = _extractedDropData['minGarages'];
      }

      if (_extractedDropData['categoryOptions'] != []) {
        _extractedDropData['categoryOptions'].map((categoryType) {
          _categoryOptions!.add(categoryType.toString());
        }).toList();
      }
      if (_extractedDropData['contractTypeOptions'] != []) {
        _extractedDropData['contractTypeOptions'].map((contractType) {
          _contractTypeOptions!.add(contractType.toString());
        }).toList();
      }
      if (_extractedDropData['locationOptions'] != []) {
        _extractedDropData['locationOptions'].map((location) {
          _locationOptions!.add(location.toString());
        }).toList();
      }
      if (_extractedDropData['conditionOptions'] != []) {
        _extractedDropData['conditionOptions'].map((conditionOptions) {
          _conditionOptions!.add(conditionOptions.toString());
        }).toList();
      }

      maxBaths = _extractedDropData['maxBaths'];
      maxGarages = _extractedDropData['maxGarages'];
      maxBeds = _extractedDropData['maxBeds'];

      // if (_extractedDropData['modelOptions'] != []) {
      //   _extractedDropData['modelOptions'].map((model) {
      //     _modelsList!.add(model.toString());
      //   }).toList();
      // }
      notifyListeners();
    } catch (error) {
      print('error-search_loadout.dart-catch(error) block');
      throw (error);
    }
    return null;
  }

  Future<DetailHouseList?>? getData(var publicId) async {
    try {
      var uri =
          // ignore: prefer_adjacent_string_concatenation
          'https://sea-turtle-app-j4ksa.ondigitalocean.app/public/property/detail/$publicId';
      //final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return DetailHouseList.fromJson(jsonResponse);
      } else {
        print(response.statusCode);
        print('The status code error :invalid response recived');
      }
    } catch (error) {
      print('This is an error OF JONA :$error');
    }
    return null;
  }
}
