import 'package:betdelalamobile/helper/utility.dart';
import 'package:betdelalamobile/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/http_exception.dart';
import '../security/validator.dart';
import '../theme/colors.dart';
import '../widget_functions/painter.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";

  const RegisterScreen({
    Key? key, //required RegisterScreenArgs args
  }) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _textStyle = const TextStyle(fontSize: 15, color: Colors.deepOrange);
  final userNameControl = TextEditingController();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final password2Control = TextEditingController();
  final phoneControl = TextEditingController();
  Utility ut = Utility();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _appBar = GlobalKey<FormState>();
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  var invisible = false;
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

  final bool _onProcess = false;
  final _registerFormKey = GlobalKey<FormState>();
  //late ThemeProvider themeProvider;
  @override
  void initState() {
    // themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    super.initState();
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
    if (!_registerFormKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _registerFormKey.currentState!.save();
    setState(() {
      //  _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).signUp(
          _authData['email']!,
          _authData['password']!,
          _authData['full name'],
          _authData['phone']!,
          _authData['confirm password'],
          context);
      // await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //         email: _authData['email']!.trim(),
      //         password: _authData['password']!.trim())
      //     .then((result) {
      //   FirebaseFirestore.instance
      //       .collection('user')
      //       .doc(result.user!.uid)
      //       .set({
      //     'email': _authData['email']!.trim(),
      //     'role': 'user', // or 'jobseeker'
      //   }
      //   );
      // }
      // );

      // VerifyEmpEmail();
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
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEEEEEE),
        body: Form(
          key: _registerFormKey,
          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.5,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 170,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 150,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    color: Theme.of(context).primaryColor,
                    child: ClipPath(
                      clipper: WaveClipperBottom(),
                      child: Container(
                        height: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(20, 100, 20, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: userNameControl,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100)),
                                labelText: "Full name",
                                enabledBorder: InputBorder.none,
                                labelStyle:
                                    const TextStyle(color: Colors.grey)),
                            validator: (value) =>
                                Sanitizer().isFullNameValid(value!),
                            onSaved: (newValue) {
                              _authData['full name'] = newValue as dynamic;
                            },
                          ),
                          TextFormField(
                            controller: phoneControl,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.phone,
                                  color: Theme.of(context).primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100)),
                                labelText: "Phone",
                                enabledBorder: InputBorder.none,
                                labelStyle:
                                    const TextStyle(color: Colors.grey)),
                            validator: (value) =>
                                Sanitizer().isPhoneValid(value!),
                            onSaved: (newValue) {
                              _authData['phone'] = newValue as dynamic;
                            },
                          ),
                          TextFormField(
                            controller: emailControl,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100)),
                                labelText: "Email",
                                enabledBorder: InputBorder.none,
                                labelStyle:
                                    const TextStyle(color: Colors.grey)),
                            validator: (value) =>
                                Sanitizer().isEmailValid(value!),
                            onSaved: (newValue) {
                              _authData['email'] = newValue as dynamic;
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
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
                              labelText: "Password",
                              enabledBorder: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.grey),
                              suffix: GestureDetector(
                                onTap: changeSate,
                                //call this method when contact with screen is removed
                                child: Icon(
                                  invisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            validator: (value) =>
                                Sanitizer().isPasswordValid(value!),
                            onSaved: (newValue) {
                              _authData['password'] = newValue as dynamic;
                            },
                          ),
                          TextFormField(
                            controller: password2Control,
                            obscureText: invisible,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.vpn_key,
                                color: Theme.of(context).primaryColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
                              labelText: "Confirm Password",
                              enabledBorder: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.grey),
                              suffix: GestureDetector(
                                onTap: changeSate,
                                //call this method when contact with screen is removed
                                child: Icon(
                                  invisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            validator: (value) => Sanitizer()
                                .isPasswordMatch(passwordControl.text, value!),
                            onSaved: (newValue) {
                              _authData['confirm password'] =
                                  newValue as dynamic;
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _submit();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              const Text("REGISTER",
                                  style: TextStyle(color: Colors.white)),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: _onProcess
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ALREADY HAVE AN ACCOUNT ? ",
                          style: TextStyle(
                              fontSize: 11,
                              color: ColorProvider.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.amber,
                          onTap: () {
                            Navigator.pop(context);
                            /*Navigator.pushNamed(
                            context, LoginScreen.routeName, arguments: LoginScreenArgs(isOnline: true));*/
                          },
                          child: Center(
                            child: Text(
                              "LogIN",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 10, bottom: 20, top: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: GestureDetector(
                                onTap: () {
                                  //themeProvider.changeTheme(3);
                                  setState(() {});
                                },
                                child: Container(
                                  //color: ColorProvider().primaryDeepOrange,
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: ColorProvider().primaryDeepOrange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: GestureDetector(
                                onTap: () {
                                  // themeProvider.changeTheme(4);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: ColorProvider().primaryDeepBlue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: GestureDetector(
                                onTap: () {
                                  // themeProvider.changeTheme(6);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: ColorProvider().primaryDeepTeal,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
