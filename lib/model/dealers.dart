import 'package:flutter/cupertino.dart';

class Dealer with ChangeNotifier {
  List<String> services = [], openHours = [], values = [], sociaMedias = [];
  List<Map<String, dynamic>> dealerContactInfo = [];
  String id,
      tag,
      companyName,
      description,
      year,
      fullName,
      ownerPid,
      phoneNumber,
      email,
      profileImageUrl,
      geoLocation;
  double rate;
  Dealer(
      {required this.id,
      required this.companyName,
      required this.dealerContactInfo,
      required this.description,
      required this.email,
      required this.fullName,
      required this.geoLocation,
      required this.openHours,
      required this.ownerPid,
      required this.phoneNumber,
      required this.profileImageUrl,
      required this.rate,
      required this.services,
      required this.sociaMedias,
      required this.tag,
      required this.values,
      required this.year});
}
