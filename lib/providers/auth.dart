// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:betdelalamobile/widget/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:like_button/like_button.dart';
import '../acounts/login.dart';
import '../model/http_exception.dart';
import '../theme/colors.dart';

class Auth with ChangeNotifier {
  String? _token, firstName, role, phone;
  DateTime? _expiryDate;
  String? pid, agentId;
  bool? isAgent, hasRestaurant;
  String? fullname;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _token = pref.getString('savedToken');
    pid = pref.getString('savedPID');
  }

  // Future<bool> get isAuth async {
  //   await checkLogin();
  //   if (token != null && pid != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future checkRole() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    role = pref.getString('savedRoles');
    isAgent = pref.getBool('savedApprovedAgent');
  }

  Future<bool> get canOrder async {
    await checkRole();
    if (role == 'USER' || role == 'AGENT' && isAgent == false) {
      return true;
    } else {
      return false;
    }
  }

  Widget favorite(int id, context, bool food, bool isLiked) {
    if (food == false) {
      return LikeButton(
          size: 18,
          isLiked: isLiked,
          onTap: pid == null
              ? (bool isLiked) {
                  return onLikeButtonTappedWithNoPid(isLiked, context);
                }
              : (bool isLiked) async {
                  return onLikeButtonTappedHouse(isLiked, id, context);
                });
    } else {
      return LikeButton(
          size: 20,
          isLiked: isLiked,
          onTap: pid == null
              ? (bool isLiked) {
                  return onLikeButtonTappedWithNoPid(isLiked, context);
                }
              : (
                  bool isLiked,
                ) {
                  return onLikeButtonTappedHouse(isLiked, id, context);
                });
    }
  }

  Future<bool> onLikeButtonTappedCars(bool isLiked, id, context) async {
    if (isLiked == true) {
      // deleteFavoriteFood(context, id, null);
      return isLiked = false;
    } else {
      // addFavoriteFood(context, id);
      return isLiked = true;
    }
  }

  Future<bool> onLikeButtonTappedHouse(bool isLiked, id, context) async {
    if (isLiked == true) {
      //  deleteFavoriteRestaurant(context, id, false, null);
      return isLiked = false;
    } else {
      //addFavoriteRestaurant(context, id);
      return isLiked = true;
    }
  }

  String convertUTF8(String value) {
    var utf8Runes = value.runes.toList();
    return const Utf8Decoder().convert(utf8Runes);
  }

  //Uri ut = Uri.parse('https://esoora-backend-prod-qiymu.ondigitalocean.app');
  Future<bool> onLikeButtonTappedWithNoPid(bool isLiked, context) async {
    // ut.loginRequestDialogue(
    //     context, 'Add to favorites?', 'You need to login to add favorites!');
    return isLiked = false;
  }

  Future<void> signUp(String? email, String password, String? fullname,
      String phone, String? confirmPassword, context) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA_6Wjm-CbGDnXHcGMu38W8cGl_gthi3N4');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'fullname': fullname,
            'phone': phone,
            'confirm password': confirmPassword,
            'returnSecureToken': true,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = json.decode(response.body);
      //print(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode == 200) {
        Uri url = Uri.parse(
            'https://zedelala-7d1e2-default-rtdb.firebaseio.com/users.json$token');
        try {
          final respons = await http.post(url,
              body: json.encode({
                'email': email,
                'fullname': fullname,
                'phone': phone,
                'roles': 'user',
                'isAgent': false
              }));
          final responseData = json.decode(respons.body);

          print(responseData);
          _token = responseData['token'];
          pid = responseData['pid'];
          firstName = responseData['firstName'];
          // phone = responseData['phone'];
          email = responseData['email'];
          role = responseData['roles'];
          isAgent = responseData['isAgent'];
          agentId = responseData['agentId'];
          hasRestaurant = responseData['hasRestaurant'];

          print(responseData['isAgent']);

          final pref = await SharedPreferences.getInstance();
          pref.setString('savedFirstName', firstName!);
          pref.setString('savedPassword', password);
          pref.setString('savedEmail', email!);
          pref.setString('savedToken', token!);
          pref.setString('savedPhoneNumber', phone);
          pref.setString('savedPID', pid!);
          pref.setString('savedRoles', role!);
          pref.setBool('savedApprovedAgent', isAgent!);

          if (role == 'user' && isAgent == false) {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const ProductGrid()));
          }
        } catch (error) {
          print(error);
        }
        // ignore: use_build_context_synchronously
        loginEnforceDialogue(context, 'SignUp successfull', true);
      }
      _token = responseData['idToken'];
      pid = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void loginEnforceDialogue(context, String title, bool signUp) {
    AwesomeDialog(
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      context: context,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: false,
      title: title,
      desc: 'Please login to continue',
      btnOkOnPress: () {
        // Navigator.of(context).pop();
        if (signUp == true) {
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const LoginScreen()),
            ModalRoute.withName('/login'),
          );
        } else {
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const LoginScreen()),
            ModalRoute.withName('/login'),
          );
        }
      },
      btnOkColor: AppColors.primary,
      buttonsTextStyle: const TextStyle(fontSize: 14, color: AppColors.white),
      btnOkIcon: Icons.login,
      btnOkText: 'Login',
      onDismissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
    ).show();
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyC13spCwP_f_SalxEbkB-wjedoF8iYENlQ');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (response.statusCode == 200) {
        print(responseData['roles']);
        _token = responseData['idToken'];
        pid = responseData['localId'];
        firstName = responseData['firstName'];
        // phone = responseData['phone'];
        email = responseData['email'];
        role = responseData['roles'];
        isAgent = responseData['isAgent'];
        agentId = responseData['agentId'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              responseData['expiresIn'],
            ),
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signIn(String? email, String? password, context) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA_6Wjm-CbGDnXHcGMu38W8cGl_gthi3N4');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      pid = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      final pref = await SharedPreferences.getInstance();
      // pref.setString('savedFirstName', fullname!);
      // pref.setString('savedPassword', password!);
      // pref.setString('savedEmail', email!);
      pref.setString('savedToken', token!);
      pref.setString('savedPID', pid!);
      // pref.setBool('savedApprovedAgent', isAgent!);
      // Flushbar(
      //   maxWidth: MediaQuery.of(context).size.width * 0.90,
      //   backgroundColor: Colors.green,
      //   flushbarPosition: FlushbarPosition.TOP,
      //   title: 'Success!',
      //   message: Provider.of<Auth>(context, listen: false)
      //       .convertUTF8('Welcome ${responseData['fullname']}!'),
      //   duration: const Duration(seconds: 3),
      // ).show(context);

      notifyListeners();
      // Navigator.of(context).push(route)
    } catch (error) {
      print(error);
    }
  }

  void logOut() {
    _token = '';
    pid = '';
    _expiryDate = null;
    notifyListeners();
  }
}
