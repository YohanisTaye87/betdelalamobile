import 'dart:async';

import 'package:betdelalamobile/acounts/register.dart';
import 'package:betdelalamobile/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/http_exception.dart';
import '../screens/products_screen.dart';
import '../security/validator.dart';

import '../widget_functions/circles.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key, required //LoginScreenArgs args
      })
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // StreamSubscription? _connectionChangeStream;
  bool isOffline = false;

  final _textStyle = const TextStyle(fontSize: 15, color: Colors.deepOrange);
  final _loginFormKey = GlobalKey<FormState>();
  var invisible = true;

  void changeSate() {
    if (invisible) {
      setState(() {
        invisible = false;
      });
    } else {
      setState(() {
        invisible = true;
      });
    }
  }

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  final passwordControl = TextEditingController();
  final phoneControl = TextEditingController();
  final Map<String, dynamic> _doctor = {};
  late bool _onProcess;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  void initState() {
    _onProcess = false;
    //NetworkManager connectionStatus = NetworkManager.getInstance();
    // _connectionChangeStream =
    //     connectionStatus.connectionChange.listen(connectionChanged);
    super.initState();
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  dispose() {
    //_connectionChangeStream!.cancel();
    _onProcess = false;
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_loginFormKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _loginFormKey.currentState!.save();
    setState(() {
      //  _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false)
          .signIn(_authData['email'], _authData['password'], context);

      Navigator.of(context).pushNamed(ProductScreen.routename);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    var isAuth = Provider.of<Auth>(context, listen: false).isAuth;
    return

        //AgentRegistration(userPublicId: userPublicId, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, userPassword: userPassword, email: email, street: street, city: city, addressId: addressId)
        Scaffold(
            backgroundColor: const Color(0xFFEEEEEE),
            body: Form(
              key: _loginFormKey,
              child: Stack(
                children: <Widget>[
                  Circles(context).topRight(),
                  Circles(context).topLeft(),
                  Circles(context).bottomRight(),
                  _align()
                ],
              ),
            ));
  }

  Align _align() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.fromLTRB(20, 210, 20, 10),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: _emailAndPassword(),
          ),
          _startLoginProcess(),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.amber,
                  onTap: () {
                    // Navigator.pushNamed(context, ForgetPassword.routeName,
                    //     arguments: ForgetPasswordArgs(isOnline: true));
                  },
                  child: Center(
                    child: Text(
                      "FORGOT PASSWORD?",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )),
          _newUser(),
          /*(isOffline)
                        ? const Text("Not connected")
                        : const Text("Connected"),*/
          Container(
            //decoration: const BoxDecoration(color: Colors.grey),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const ProductScreen(
                                    // isAuth: false,
                                    )),
                        ModalRoute.withName('/bottomNav'));
                  },
                  child: const Text('Continue withOut Account')),
            ),
          ),
        ],
      ),
    );
  }

  Column _emailAndPassword() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: phoneControl,
          decoration: InputDecoration(
              icon: Icon(
                Icons.phone,
                color: Theme.of(context).primaryColor,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "Email",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
          //validator: (value) => Sanitizer().isPhoneValid(value!),
          validator: (value) => Sanitizer().isEmailValid(value!),
          onSaved: (value) {
            _authData["email"] = value as dynamic;
          },
        ),
        TextFormField(
          controller: passwordControl,
          obscureText: invisible,
          decoration: InputDecoration(
            icon: Icon(
              Icons.vpn_key,
              color: Theme.of(context).primaryColor,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100)),
            labelText: "Password",
            enabledBorder: InputBorder.none,
            labelStyle: const TextStyle(color: Colors.grey),
            suffix: GestureDetector(
              onTap: _onProcess ? null : changeSate,
              //call this method when contact with screen is removed
              child: Icon(
                invisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          validator: (value) => Sanitizer().isPasswordValid(value!),
          onSaved: (value) {
            _authData["password"] = value as dynamic;
          },
        ),
      ],
    );
  }

  Container _startLoginProcess() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 45,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [Theme.of(context).primaryColor, Colors.amber],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Material(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  splashColor: Colors.amber,
                  onTap: () async {
                    _submit();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text("SIGN IN",
                          style: TextStyle(color: Colors.white)),
                      const Spacer(),
                      Align(
                        widthFactor: 2,
                        alignment: Alignment.centerRight,
                        child: _onProcess
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _newUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "DON'T HAVE AN ACCOUNT ? ",
          style: TextStyle(
              fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.amber,
          onTap: () {
            Navigator.pushNamed(
              context, RegisterScreen.routeName,
              // arguments: //RegisterScreenArgs(isOnline: true
            );
          },
          child: Center(
            child: Text(
              "SIGN UP",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
