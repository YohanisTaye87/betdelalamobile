// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../widget/post_pro.dart';

class Product with ChangeNotifier {
  final String id;
  final String ProductName;
  final String City;
  final String StreetAdrress;
  final String Tags;
  final String description;
  final String lat;
  final String lng;
  final String garage;
  final String beds;
  final String? selectedCondition;
  final String? selectedPropertyType;
  final List<HouseImageEntity> houseImageEntites;
  final String price;
  bool isFavorite;

  Product(
      {required this.id,
      required this.ProductName,
      required this.City,
      required this.StreetAdrress,
      required this.Tags,
      required this.description,
      required this.lat,
      required this.lng,
      required this.selectedCondition,
      required this.selectedPropertyType,
      required this.beds,
      required this.houseImageEntites,
      required this.garage,
      required this.price,
      this.isFavorite = false});

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(
    String? token,
    String? userId,
  ) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://zedelala-7d1e2-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      print(error);
      _setFavValue(oldStatus);
    }
  }

  // void toggleFavoriteStatus() {
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  // }
}
