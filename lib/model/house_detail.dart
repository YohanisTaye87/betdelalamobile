class DetailHouseList {
  DetailHouseList({
    required this.id,
    // required this.publicId,
    required this.title,
    required this.description,
    // required this.tags,
    required this.propertyImagesList,
    // required this.street,
    required this.addressLookups,
    // required this.latitude,
    // required this.longitude,
    // required this.propertyCategory,
     required this.enumContractType,
    required this.enumCurrencyType,
    // required this.enumPropertyStatus,
    // required this.approvedStatus,
    required this.price,
    // required this.pricePostfixText,
    // required this.contractCondition,
    // required this.preCondition,
    required this.bedrooms,
    required this.bathrooms,
    required this.parkingSpace,
    required this.area,
    // required this.areaPostfixText,
    required this.yearBuilt,
    required this.propertyFeaturesList,
    // required this.additionalFeatures,
    // required this.propertyCondition,
    // required this.nearByFacilities,
    // required this.postedBy,
    // required this.agent,
    // required this.agency,
    // required this.expiredDate,
    // required this.publishedTime,
    // required this.updatedOn,
    // required this.featured,
  });

  final int id;
  // final String publicId;
  final String title;
  final String description;
  // final String tags;
  final List<PropertyImagesList> propertyImagesList;
  // final String street;
  final AddressLookups? addressLookups;
  // final String latitude;
  // final String longitude;
  // final Property? propertyCategory;
   final String enumContractType;
  final String enumCurrencyType;
  // final String enumPropertyStatus;
  // final String approvedStatus;
  final int price;
  // final String pricePostfixText;
  // final String contractCondition;
  // final String preCondition;
  final int bedrooms;
  final int bathrooms;
  final int parkingSpace;
  final double area;
  // final String areaPostfixText;
   final int yearBuilt;
   final List<Property> propertyFeaturesList;
  // final String additionalFeatures;
  // final String propertyCondition;
  // final String nearByFacilities;
  // final PostedBy? postedBy;
  // final Agent? agent;
  // final Agency? agency;
  // final DateTime? expiredDate;
  // final DateTime? publishedTime;
  // final DateTime? updatedOn;
  // final bool featured;

  factory DetailHouseList.fromJson(Map<String, dynamic> json) {
    return DetailHouseList(
      id: json["id"] ?? 0,
      // publicId: json["publicId"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      // tags: json["tags"] ?? "",
      propertyImagesList: json["propertyImagesList"] == null
          ? []
          : List<PropertyImagesList>.from(json["propertyImagesList"]!
              .map((x) => PropertyImagesList.fromJson(x))),
      // street: json["street"] ?? "",
      addressLookups: json["addressLookups"] == null
          ? null
          : AddressLookups.fromJson(json["addressLookups"]),
      // latitude: json["latitude"] ?? "",
      // longitude: json["longitude"] ?? "",
      // propertyCategory: json["propertyCategory"] == null ? null : Property.fromJson(json["propertyCategory"]),
      enumContractType: json["enumContractType"] ?? "",
      enumCurrencyType: json["enumCurrencyType"] ?? "",
      // enumPropertyStatus: json["enumPropertyStatus"] ?? "",
      // approvedStatus: json["approvedStatus"] ?? "",
      price: json["price"] ?? 0,
      // pricePostfixText: json["pricePostfixText"] ?? "",
      // contractCondition: json["contractCondition"] ?? "",
      // preCondition: json["preCondition"] ?? "",
      bedrooms: json["bedrooms"] ?? 0,
      bathrooms: json["bathrooms"] ?? 0,
      parkingSpace: json["parkingSpace"] ?? 0,
      area: json["area"] ?? 0,
      // areaPostfixText: json["areaPostfixText"] ?? "",
       yearBuilt: json["yearBuilt"] ?? 0,
       propertyFeaturesList: json["propertyFeaturesList"] == null ? [] : List<Property>.from(json["propertyFeaturesList"]!.map((x) => Property.fromJson(x))),
      // additionalFeatures: json["additionalFeatures"] ?? "",
      // propertyCondition: json["propertyCondition"] ?? "",
      // nearByFacilities: json["nearByFacilities"] ?? "",
      // postedBy: json["postedBy"] == null ? null : PostedBy.fromJson(json["postedBy"]),
      // agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
      // agency: json["agency"] == null ? null : Agency.fromJson(json["agency"]),
      // expiredDate: json["expiredDate"] == null ? null : DateTime.parse(json["expiredDate"]),
      // publishedTime: json["publishedTime"] == null ? null : DateTime.parse(json["publishedTime"]),
      // updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
      // featured: json["featured"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        // "publicId": publicId,
        "title": title,
        "description": description,
        // "tags": tags,
        "propertyImagesList": List<PropertyImagesList>.from(
            propertyImagesList.map((x) => x.toJson())),
        // "street": street,
        "addressLookups": addressLookups?.toJson(),
        // "latitude": latitude,
        // "longitude": longitude,
        // "propertyCategory": propertyCategory?.toJson(),
        // "enumContractType": enumContractType,
        "enumCurrencyType": enumCurrencyType,
        // "enumPropertyStatus": enumPropertyStatus,
        // "approvedStatus": approvedStatus,
        "price": price,
        // "pricePostfixText": pricePostfixText,
        // "contractCondition": contractCondition,
        // "preCondition": preCondition,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
         "parkingSpace": parkingSpace,
        "area": area,
        // "areaPostfixText": areaPostfixText,
         "yearBuilt": yearBuilt,
         "propertyFeaturesList": List<Property>.from(propertyFeaturesList.map((x) => x.toJson())),
        // "additionalFeatures": additionalFeatures,
        // "propertyCondition": propertyCondition,
        // "nearByFacilities": nearByFacilities,
        // "postedBy": postedBy?.toJson(),
        // "agent": agent?.toJson(),
        // "agency": agency?.toJson(),
        // "expiredDate": expiredDate?.toIso8601String(),
        // "publishedTime": publishedTime?.toIso8601String(),
        // "updatedOn": updatedOn?.toIso8601String(),
        // "featured": featured,
      };
}

class AddressLookups {
  AddressLookups({
    required this.id,
    required this.city,
    required this.subCity,
  });

  final int id;
  final String city;
  final String subCity;

  factory AddressLookups.fromJson(Map<String, dynamic> json) {
    return AddressLookups(
      id: json["id"] ?? 0,
      city: json["city"] ?? "",
      subCity: json["subCity"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "subCity": subCity,
      };
}

class Agency {
  Agency({
    required this.id,
    required this.agencyPublicId,
    required this.name,
    required this.thumbnail,
    required this.mobileNumber,
    required this.email,
    required this.officeNumber,
    required this.faxNumber,
    required this.website,
    required this.street,
    required this.addressLookups,
    required this.agent,
    required this.agencyRatingList,
    required this.agencyFeedbacksList,
    required this.properties,
    required this.createdOn,
  });

  final int id;
  final String agencyPublicId;
  final String name;
  final String thumbnail;
  final String mobileNumber;
  final String email;
  final String officeNumber;
  final String faxNumber;
  final String website;
  final String street;
  final AddressLookups? addressLookups;
  final List<String> agent;
  final List<AgenList> agencyRatingList;
  final List<AgencyFeedbacksList> agencyFeedbacksList;
  final List<String> properties;
  final DateTime? createdOn;

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json["id"] ?? 0,
      agencyPublicId: json["agencyPublicId"] ?? "",
      name: json["name"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      mobileNumber: json["mobileNumber"] ?? "",
      email: json["email"] ?? "",
      officeNumber: json["officeNumber"] ?? "",
      faxNumber: json["faxNumber"] ?? "",
      website: json["website"] ?? "",
      street: json["street"] ?? "",
      addressLookups: json["addressLookups"] == null
          ? null
          : AddressLookups.fromJson(json["addressLookups"]),
      agent: json["agent"] == null
          ? []
          : List<String>.from(json["agent"]!.map((x) => x)),
      agencyRatingList: json["agencyRatingList"] == null
          ? []
          : List<AgenList>.from(
              json["agencyRatingList"]!.map((x) => AgenList.fromJson(x))),
      agencyFeedbacksList: json["agencyFeedbacksList"] == null
          ? []
          : List<AgencyFeedbacksList>.from(json["agencyFeedbacksList"]!
              .map((x) => AgencyFeedbacksList.fromJson(x))),
      properties: json["properties"] == null
          ? []
          : List<String>.from(json["properties"]!.map((x) => x)),
      createdOn:
          json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "agencyPublicId": agencyPublicId,
        "name": name,
        "thumbnail": thumbnail,
        "mobileNumber": mobileNumber,
        "email": email,
        "officeNumber": officeNumber,
        "faxNumber": faxNumber,
        "website": website,
        "street": street,
        "addressLookups": addressLookups?.toJson(),
        "agent": List<String>.from(agent.map((x) => x)),
        "agencyRatingList":
            List<AgenList>.from(agencyRatingList.map((x) => x.toJson())),
        "agencyFeedbacksList": List<AgencyFeedbacksList>.from(
            agencyFeedbacksList.map((x) => x.toJson())),
        "properties": List<String>.from(properties.map((x) => x)),
        "createdOn": createdOn?.toIso8601String(),
      };
}

class AgencyFeedbacksList {
  AgencyFeedbacksList({
    required this.id,
    required this.user,
    required this.agency,
    required this.feedback,
    required this.replayToId,
    required this.createdOn,
    required this.replay,
  });

  final int id;
  final PostedBy? user;
  final String agency;
  final String feedback;
  final int replayToId;
  final DateTime? createdOn;
  final bool replay;

  factory AgencyFeedbacksList.fromJson(Map<String, dynamic> json) {
    return AgencyFeedbacksList(
      id: json["id"] ?? 0,
      user: json["user"] == null ? null : PostedBy.fromJson(json["user"]),
      agency: json["agency"] ?? "",
      feedback: json["feedback"] ?? "",
      replayToId: json["replayToId"] ?? 0,
      createdOn:
          json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
      replay: json["replay"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "agency": agency,
        "feedback": feedback,
        "replayToId": replayToId,
        "createdOn": createdOn?.toIso8601String(),
        "replay": replay,
      };
}

class PostedBy {
  PostedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.thumbnail,
    required this.userName,
    required this.passWord,
    required this.phoneNumber,
    required this.city,
    required this.street,
    required this.isAgent,
    required this.verifiedEmail,
    required this.isEmailVerified,
    required this.userPublicId,
    required this.roles,
    required this.agentPid,
    required this.bio,
    required this.areaOfFocus,
    required this.specialization,
    required this.website,
    required this.facebookLink,
    required this.twitterLink,
    required this.instagramLink,
    required this.linkedinLink,
    required this.agencyPid,
    required this.addressLookups,
    required this.createdOn,
    required this.updatedOn,
    required this.locked,
    required this.enabled,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String thumbnail;
  final String userName;
  final String passWord;
  final String phoneNumber;
  final String city;
  final String street;
  final bool isAgent;
  final String verifiedEmail;
  final bool isEmailVerified;
  final String userPublicId;
  final List<Role> roles;
  final String agentPid;
  final String bio;
  final String areaOfFocus;
  final String specialization;
  final String website;
  final String facebookLink;
  final String twitterLink;
  final String instagramLink;
  final String linkedinLink;
  final String agencyPid;
  final AddressLookups? addressLookups;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final bool locked;
  final bool enabled;

  factory PostedBy.fromJson(Map<String, dynamic> json) {
    return PostedBy(
      id: json["id"] ?? 0,
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      userName: json["userName"] ?? "",
      passWord: json["passWord"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      city: json["city"] ?? "",
      street: json["street"] ?? "",
      isAgent: json["isAgent"] ?? false,
      verifiedEmail: json["verifiedEmail"] ?? "",
      isEmailVerified: json["isEmailVerified"] ?? false,
      userPublicId: json["userPublicId"] ?? "",
      roles: json["roles"] == null
          ? []
          : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
      agentPid: json["agentPid"] ?? "",
      bio: json["bio"] ?? "",
      areaOfFocus: json["areaOfFocus"] ?? "",
      specialization: json["specialization"] ?? "",
      website: json["website"] ?? "",
      facebookLink: json["facebookLink"] ?? "",
      twitterLink: json["twitterLink"] ?? "",
      instagramLink: json["instagramLink"] ?? "",
      linkedinLink: json["linkedinLink"] ?? "",
      agencyPid: json["agencyPid"] ?? "",
      addressLookups: json["addressLookups"] == null
          ? null
          : AddressLookups.fromJson(json["addressLookups"]),
      createdOn:
          json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
      updatedOn:
          json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
      locked: json["locked"] ?? false,
      enabled: json["enabled"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "thumbnail": thumbnail,
        "userName": userName,
        "passWord": passWord,
        "phoneNumber": phoneNumber,
        "city": city,
        "street": street,
        "isAgent": isAgent,
        "verifiedEmail": verifiedEmail,
        "isEmailVerified": isEmailVerified,
        "userPublicId": userPublicId,
        "roles": List<Role>.from(roles.map((x) => x.toJson())),
        "agentPid": agentPid,
        "bio": bio,
        "areaOfFocus": areaOfFocus,
        "specialization": specialization,
        "website": website,
        "facebookLink": facebookLink,
        "twitterLink": twitterLink,
        "instagramLink": instagramLink,
        "linkedinLink": linkedinLink,
        "agencyPid": agencyPid,
        "addressLookups": addressLookups?.toJson(),
        "createdOn": createdOn?.toIso8601String(),
        "updatedOn": updatedOn?.toIso8601String(),
        "locked": locked,
        "enabled": enabled,
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AgenList {
  AgenList({
    required this.id,
    required this.user,
    required this.agency,
    required this.rating,
    required this.agent,
  });

  final int id;
  final PostedBy? user;
  final String agency;
  final int rating;
  final String agent;

  factory AgenList.fromJson(Map<String, dynamic> json) {
    return AgenList(
      id: json["id"] ?? 0,
      user: json["user"] == null ? null : PostedBy.fromJson(json["user"]),
      agency: json["agency"] ?? "",
      rating: json["rating"] ?? 0,
      agent: json["agent"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "agency": agency,
        "rating": rating,
        "agent": agent,
      };
}

class Agent {
  Agent({
    required this.id,
    required this.agentPublicId,
    required this.firstName,
    required this.lastName,
    required this.thumbnail,
    required this.areaOfFocus,
    required this.specialization,
    required this.phoneNumber,
    required this.email,
    required this.street,
    required this.addressLookups,
    required this.website,
    required this.facebookLink,
    required this.twitterLink,
    required this.instagramLink,
    required this.linkedinLink,
    required this.agentFeedbacksList,
    required this.agentRatingsList,
    required this.agency,
    required this.properties,
    required this.createdOn,
  });

  final int id;
  final String agentPublicId;
  final String firstName;
  final String lastName;
  final String thumbnail;
  final String areaOfFocus;
  final String specialization;
  final String phoneNumber;
  final String email;
  final String street;
  final AddressLookups? addressLookups;
  final String website;
  final String facebookLink;
  final String twitterLink;
  final String instagramLink;
  final String linkedinLink;
  final List<AgentFeedbacksList> agentFeedbacksList;
  final List<AgenList> agentRatingsList;
  final Agency? agency;
  final List<String> properties;
  final DateTime? createdOn;

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json["id"] ?? 0,
      agentPublicId: json["agentPublicId"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      areaOfFocus: json["areaOfFocus"] ?? "",
      specialization: json["specialization"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      email: json["email"] ?? "",
      street: json["street"] ?? "",
      addressLookups: json["addressLookups"] == null
          ? null
          : AddressLookups.fromJson(json["addressLookups"]),
      website: json["website"] ?? "",
      facebookLink: json["facebookLink"] ?? "",
      twitterLink: json["twitterLink"] ?? "",
      instagramLink: json["instagramLink"] ?? "",
      linkedinLink: json["linkedinLink"] ?? "",
      agentFeedbacksList: json["agentFeedbacksList"] == null
          ? []
          : List<AgentFeedbacksList>.from(json["agentFeedbacksList"]!
              .map((x) => AgentFeedbacksList.fromJson(x))),
      agentRatingsList: json["agentRatingsList"] == null
          ? []
          : List<AgenList>.from(
              json["agentRatingsList"]!.map((x) => AgenList.fromJson(x))),
      agency: json["agency"] == null ? null : Agency.fromJson(json["agency"]),
      properties: json["properties"] == null
          ? []
          : List<String>.from(json["properties"]!.map((x) => x)),
      createdOn:
          json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "agentPublicId": agentPublicId,
        "firstName": firstName,
        "lastName": lastName,
        "thumbnail": thumbnail,
        "areaOfFocus": areaOfFocus,
        "specialization": specialization,
        "phoneNumber": phoneNumber,
        "email": email,
        "street": street,
        "addressLookups": addressLookups?.toJson(),
        "website": website,
        "facebookLink": facebookLink,
        "twitterLink": twitterLink,
        "instagramLink": instagramLink,
        "linkedinLink": linkedinLink,
        "agentFeedbacksList": List<AgentFeedbacksList>.from(
            agentFeedbacksList.map((x) => x.toJson())),
        "agentRatingsList":
            List<AgenList>.from(agentRatingsList.map((x) => x.toJson())),
        "agency": agency?.toJson(),
        "properties": List<String>.from(properties.map((x) => x)),
        "createdOn": createdOn?.toIso8601String(),
      };
}

class AgentFeedbacksList {
  AgentFeedbacksList({
    required this.id,
    required this.user,
    required this.agent,
    required this.feedback,
    required this.replayToId,
    required this.createdOn,
  });

  final int id;
  final PostedBy? user;
  final String agent;
  final String feedback;
  final int replayToId;
  final DateTime? createdOn;

  factory AgentFeedbacksList.fromJson(Map<String, dynamic> json) {
    return AgentFeedbacksList(
      id: json["id"] ?? 0,
      user: json["user"] == null ? null : PostedBy.fromJson(json["user"]),
      agent: json["agent"] ?? "",
      feedback: json["feedback"] ?? "",
      replayToId: json["replayToId"] ?? 0,
      createdOn:
          json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "agent": agent,
        "feedback": feedback,
        "replayToId": replayToId,
        "createdOn": createdOn?.toIso8601String(),
      };
}

class Property {
  Property({
    required this.id,
    required this.name,
    required this.icon,
    required this.tags,
    required this.description,
    required this.createdOn,
    required this.updatedOn,
  });

  final int id;
  final String name;
  final String icon;
  final String tags;
  final String description;
  final DateTime? createdOn;
  final DateTime? updatedOn;

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      icon: json["icon"] ?? "",
      tags: json["tags"] ?? "",
      description: json["description"] ?? "",
      createdOn:
          json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
      updatedOn:
          json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "tags": tags,
        "description": description,
        "createdOn": createdOn?.toIso8601String(),
        "updatedOn": updatedOn?.toIso8601String(),
      };
}

class PropertyImagesList {
  PropertyImagesList({
    required this.id,
    required this.url,
    required this.primary,
  });

  final int id;
  final String url;
  final bool primary;

  factory PropertyImagesList.fromJson(Map<String, dynamic> json) {
    return PropertyImagesList(
      id: json["id"] ?? 0,
      url: json["url"] ?? "",
      primary: json["primary"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "primary": primary,
      };
}
