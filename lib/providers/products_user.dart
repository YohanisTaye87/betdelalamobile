import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:betdelalamobile/model/http_exception.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/Products.dart';

import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];
  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    print(filterByUser);
    print(userId);

    print("creatorId");

    final filterString =
        filterByUser == true ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    print(filterString);

    Uri url = Uri.parse(
        'https://zedelala-7d1e2-default-rtdb.firebaseio.com/Houses.json?auth=$authToken&$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      url = Uri.parse(
          'https://zedelala-7d1e2-default-rtdb.firebaseio.com/userFavourite/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodDara) {
        loadedProducts.add(Product(
            id: prodId,
            City: prodDara['city'],
            ProductName: prodDara['ProductName'],
            StreetAdrress: prodDara['StreetAdrress'],
            Tags: prodDara['Tags'],
            description: prodDara['description'],
            lat: prodDara['lat'],
            lng: prodDara['lng'],
            houseImageEntites: prodDara['houseImageEntites'],
            garage: prodDara['garage'],
            beds: prodDara['beds'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
            selectedCondition: prodDara['Condition'],
            selectedPropertyType: prodDara['Type'],
            price: prodDara['price']));
      });

      _items = loadedProducts;
      //print();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  // Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
  //   final filterString =
  //       filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
  //   Uri url = Uri.parse(
  //       'https://zedelala-7d1e2-default-rtdb.firebaseio.com/Houses.json?auth=$authToken&$filterString');
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedData == null) {
  //       return;
  //     }

  //     // url = Uri.parse(
  //     //     'https://zedelala-7d1e2-default-rtdb.firebaseio.com/userFavourite/$userId?auth=$authToken');
  //     // final favoriteResponse = await http.get(url);
  //     // final favoriteData = json.decode(favoriteResponse.body);
  //     final List<Product> loadedProducts = [];
  //     extractedData.forEach((prodId, prodDara) {
  //       loadedProducts.add(Product(
  //           id: prodId,
  //           City: prodDara['city'],
  //           ProductName: prodDara['ProductName'],
  //           StreetAdrress: prodDara['StreetAdrress'],
  //           Tags: prodDara['Tags'],
  //           description: prodDara['description'],
  //           lat: prodDara['lat'],
  //           lng: prodDara['lng'],
  //           garage: prodDara['garage'],
  //           beds: prodDara['beds'],
  //           // isFavorite:
  //           //     favoriteData == null ? false : favoriteData[prodId] ?? false,
  //           selectedCondition: prodDara['Condition'],
  //           selectedPropertyType: prodDara['Type'],
  //           price: prodDara['price']));
  //     });

  //     _items = loadedProducts;
  //     //print();
  //     notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<void> addProduct(Product prod, context) async {
    Uri url = Uri.parse(
        'https://zedelala-7d1e2-default-rtdb.firebaseio.com/Houses.json?auth=$authToken');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'City': prod.City,
          'ProductName': prod.ProductName,
          'StreetAdrress': prod.StreetAdrress,
          'Tags': prod.Tags,
          'description': prod.description,
          'lat': prod.lat,
          'lng': prod.lng,
          'garage': prod.garage,
          'houseImageEntites': prod.houseImageEntites,
          'beds': prod.beds,
          'Condition': prod.selectedCondition,
          'Type': prod.selectedPropertyType,
          'creatorId': userId,
          'price': prod.price,
          'isFavourite': prod.isFavorite
        }),
      );

      final NewProduct = Product(
        id: json.decode(response.body)['name'],
        ProductName: prod.ProductName,
        City: prod.City,
        StreetAdrress: prod.StreetAdrress,
        Tags: prod.Tags,
        description: prod.description,
        lat: prod.lat,
        lng: prod.lng,
        houseImageEntites: prod.houseImageEntites,
        selectedCondition: prod.selectedCondition,
        selectedPropertyType: prod.selectedPropertyType,
        beds: prod.beds,
        garage: prod.id,
        price: prod.price,
        //isFavorite: prod.isFavorite
      );

      //_items.add(NewProduct);
      _items.insert(0, NewProduct);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          animType: AnimType.TOPSLIDE,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: true,
          title: 'Registration sucess!',
          desc: 'Now user can see your products',
          btnOkOnPress: () {
            // Navigator.of(context).pop();
          },
          btnOkIcon: Icons.check_circle,
          btnOkText: 'Ok',
          btnCancelOnPress: () {},
          btnCancelIcon: Icons.cancel,
          onDismissCallback: (type) {
            print('Dialog Dissmiss from callback $type');
          },
        ).show();
        //dialogue('We are not able to process your request at this time!');
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  //void dialogue(String message) {}

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://zedelala-7d1e2-default-rtdb.firebaseio.com/Houses/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'city': newProduct.City,
            'ProductName': newProduct.ProductName,
            'StreetAdrress': newProduct.StreetAdrress,
            'Tags': newProduct.Tags,
            'description': newProduct.description,
            'houseImageEntites': newProduct.houseImageEntites,
            'lat': newProduct.lat,
            'lng': newProduct.lng,
            'garage': newProduct.garage,
            'beds': newProduct.beds,
            'Condition': newProduct.selectedCondition,
            'Type': newProduct.selectedPropertyType,
            'price': newProduct.price
          }));
    }
    items[prodIndex] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id,context) async {
    final url = Uri.parse(
        'https://zedelala-7d1e2-default-rtdb.firebaseio.com/Houses/$id.json?$authToken');
    final existingProductIndex = items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = items[existingProductIndex];
    items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(
      url,
    );
    if (response.statusCode >= 400) {
      items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    if (response.statusCode == 200) {
      AwesomeDialog(
          context: context,
          animType: AnimType.TOPSLIDE,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: true,
          title: 'The product is deleted successfully!',
          desc: 'Now user can not see your products',
          btnOkOnPress: () {
            //Navigator.of(context).pop();
          },
          btnOkIcon: Icons.check_circle,
          btnOkText: 'Ok',
          btnCancelOnPress: () {},
          btnCancelIcon: Icons.cancel,
          onDismissCallback: (type) {
            print('Dialog Dissmiss from callback $type');
          },
        ).show();
    }
    existingProduct = null;
  }
}
