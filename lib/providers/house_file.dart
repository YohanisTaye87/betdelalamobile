import 'package:flutter/foundation.dart';

class HouseFile with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String price;
  final String location;
  final String rentInformation;
  final List<String> specification;
  final List<String> description;
  final String information;

  HouseFile(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price,
      required this.location,
      required this.rentInformation,
      required this.specification,
      required this.description,
      required this.information
      });
}
