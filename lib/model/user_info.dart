class UserInfoModel {
  UserInfoModel({
    required this.userPublicId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userPassword,
    required this.email,
    required this.address,
    required this.roles,
    required this.agentId,
    required this.isAgent,
    required this.hasRestaurants,
  });

  final String userPublicId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userPassword;
  final String? email;
  final Address address;
  final List<Role>? roles;
  final dynamic agentId;
  final bool? isAgent;
  final bool hasRestaurants;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        userPublicId: json["userPublicId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        userPassword: json["userPassword"],
        email: json["email"],
        address: Address.fromJson(json["address"]),
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        agentId: json["agentId"],
        isAgent: json["isAgent"],
        hasRestaurants: json["hasRestaurants"],
      );

  Map<String, dynamic> toJson() => {
        "userPublicId": userPublicId,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "userPassword": userPassword,
        "email": email,
        "address": address.toJson(),
        "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
        "agentId": agentId,
        "isAgent": isAgent,
        "hasRestaurants": hasRestaurants,
      };
}

class Address {
  Address({
    required this.id,
    required this.street,
    required this.city,
  });

  final int id;
  final String? street;
  final String city;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        street: json["street"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "city": city,
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
