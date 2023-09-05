class HouseImageEntity {
  HouseImageEntity({
    this.id,
    required this.url,
  });

  final int? id;
  final String url;

  factory HouseImageEntity.fromJson(Map<String, dynamic> json) =>
      HouseImageEntity(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
class Address {
  Address({
    this.id,
    required this.street,
    required this.city,
    required this.email,
  });

  final int? id;
  final String street;
  final String city;
  final String email;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        street: json["street"],
        city: json["city"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "city": city,
        "email": email,
      };
}

class OpenHour {
  OpenHour({
    this.id,
    required this.openDays,
    required this.startTime,
    required this.endTime,
  });

  final int? id;
  final String openDays;
  final String startTime;
  final String endTime;

  factory OpenHour.fromJson(Map<String, dynamic> json) => OpenHour(
        id: json["id"],
        openDays: json["openDays"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "openDays": openDays,
        "startTime": startTime,
        "endTime": endTime,
      };
}
