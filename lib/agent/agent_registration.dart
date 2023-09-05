// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

//import 'package:esoora_food_delivery/widgets/button_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:betdelalamobile/widget/add_edit_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../../models/user_info_model.dart';
//import '../../helpers/fetch_and_post.dart';
import '../helper/utility.dart';
import '../providers/auth.dart';
import '../theme/colors.dart';
import '../widget/user_input.dart';
import '../widget_functions/style.dart';
//import '../../widgets/user_input.dart';

// ignore: must_be_immutable
class AgentRegistration extends StatefulWidget {
  AgentRegistration({userPublicId});
  String firstName = 'Yohanis',
      lastName = 'Yohanis',
      phoneNumber = 'Yohanis',
      userPassword = 'Yohanis',
      email = 'yohanis@gmail.com',
      street = 'Addis abeba',
      city = 'Addis abeba';
  var userPublicId;

  @override
  static const routename = '/agent';
  @override
  State<AgentRegistration> createState() => _AgentRegistrationState();
}

class _AgentRegistrationState extends State<AgentRegistration> {
  int? addressId;
  final GlobalKey<FormState> _formKey = GlobalKey();
  //final GlobalKey<FormState> _formKey1 = GlobalKey();
  Utility ut = Utility();
  TextEditingController nameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String? savedPassword;
  int? agentId;
  bool _obscureText = true, disabledButton = true;
  @override
  void didChangeDependencies() {
    _retreavePassword();
    streetAddressController.text = widget.street;
    cityController.text = widget.city;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  onRefresh() {
    _retreavePassword();
    nameController.text = widget.firstName;
    lNameController.text = widget.lastName;
    // phoneController.text = widget.phoneNumber
    // emailController.text = widget.email;
    streetAddressController.text = widget.street;
    cityController.text = widget.city;
    setState(() {});
  }

  Future _retreavePassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    savedPassword = pref.getString('savedPassword');
  }

  Future addAgent() async {
    await Provider.of<Auth>(context, listen: false).checkLogin();
    final url = Uri.parse(
        'https://zedelala-7d1e2-default-rtdb.firebaseio.com/agent.json');
    try {
      final jsonBody = json.encode({
        "user": {
          "userName": nameController,
          "passWord": savedPassword,
          "firstName": nameController.text,
          "lastName": lNameController.text,
          //"phoneNumber": widget.phoneNumber,
          "userPublicId": widget.userPublicId,
          "address": {
            "street": streetAddressController.text,
            "city": cityController.text
          },
        },
      });
      final response = await http.post(
        url,
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              ' Bearer ${Provider.of<Auth>(context, listen: false).token}',
          'pid': '${Provider.of<Auth>(context, listen: false).pid}',
        },
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      agentId = responseData['id'];
      print(agentId);
      if (response.statusCode == 200) {
        final pref = await SharedPreferences.getInstance();
        Navigator.of(context).pop();
        ut.scaffoldMessage(context, 'You are an agent!', Colors.green);
        pref.setInt('savedAgentId', agentId!);
        pref.setString('savedRoles', 'AGENT');
      } else {
        ut.scaffoldMessage(
            context,
            'We are not able to process your request at this time!',
            Colors.red);
      }
    } on TimeoutException {
      ut.scaffoldMessage(
          context, 'Network is timedout! please try again.', Colors.red);
    } on SocketException {
      ut.scaffoldMessage(
          context,
          'Network is unreachable! Please check your internet connection.',
          Colors.red);
    } on Error {
      print(Error);
      ut.scaffoldMessage(context, 'Error Occured!', Colors.red);
    }
  }

  @override
  void dispose() {
    addAgent();
    // TODO: implement dispose
    super.dispose();
  }

  dynamic _toggle(setState) {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context).isAuth;
    print(auth);
    return Stack(
      children: [
        // Image.asset(
        //   "assets/icons/betdelala.jpg",
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        // ),
        Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.black,
            elevation: 0,
            centerTitle: true,
            leading: const BackButton(),
            title: const TitleFont(text: 'Become An Agent'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: UserInput(
                          alert: false,
                          maxLength: 20,
                          capitalization: TextCapitalization.words,
                          controller: nameController,
                          hintTitle: 'First Name',
                          keyboardType: TextInputType.name,
                          context: context,
                          validator: (val) {
                            if (val!.isEmpty ||
                                val == ' ' ||
                                val == '  ' ||
                                val == '   ' ||
                                val == '    ') {
                              return 'Please enter valid Name!';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            return nameController.text = val.toString();
                          },
                          onChanged: (val) {
                            setState(() {
                              disabledButton = false;
                            });
                            return null;
                          },
                        )),
                    Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: UserInput(
                          alert: false,
                          maxLength: 20,
                          capitalization: TextCapitalization.words,
                          controller: lNameController,
                          hintTitle: 'Last Name',
                          keyboardType: TextInputType.name,
                          context: context,
                          validator: (val) {
                            if (val!.isEmpty ||
                                val == ' ' ||
                                val == '  ' ||
                                val == '   ' ||
                                val == '    ') {
                              return 'Please enter valid Name!';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            return lNameController.text = val.toString();
                          },
                          onChanged: (val) {
                            setState(() {
                              disabledButton = false;
                            });
                            return null;
                          },
                        )),
                    // GestureDetector(
                    //   onTap: () {
                    //     Provider.of<Fetch>(context, listen: false)
                    //         .scaffoldMessage(context,
                    //             'Can not change existing email!', Colors.red);
                    //   },
                    //   child: Container(
                    //       padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    //       child: UserInput(
                    //         enabled: false,
                    //         alert: false,
                    //         maxLength: 20,
                    //         controller: emailController,
                    //         hintTitle: 'Email',
                    //         keyboardType: TextInputType.name,
                    //         context: context,
                    //         validator: (val) {
                    //           if (val!.isEmpty ||
                    //               !(RegExp(
                    //                       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //                   .hasMatch(val.toString()))) {
                    //             return 'Invalid email address';
                    //           }
                    //           return null;
                    //         },
                    //         onSaved: (val) {
                    //           return emailController.text = val.toString();
                    //         },
                    //         onChanged: (val) {
                    //           setState(() {
                    //             disabledButton = false;
                    //           });
                    //         },
                    //       )),
                    // ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: UserInput(
                        alert: false,
                        maxLength: 20,
                        capitalization: TextCapitalization.words,
                        controller: streetAddressController,
                        hintTitle: 'Street Address',
                        keyboardType: TextInputType.streetAddress,
                        context: context,
                        validator: (val) {
                          if (val!.isEmpty ||
                              val == ' ' ||
                              val == '  ' ||
                              val == '   ' ||
                              val == '    ') {
                            return 'Please enter valid Street Address!';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          return streetAddressController.text = val.toString();
                        },
                        onChanged: (val) {
                          setState(() {
                            disabledButton = false;
                          });
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: UserInput(
                        alert: false,
                        maxLength: 20,
                        capitalization: TextCapitalization.words,
                        controller: cityController,
                        hintTitle: 'City',
                        keyboardType: TextInputType.streetAddress,
                        context: context,
                        validator: (val) {
                          if (val!.isEmpty ||
                              val == ' ' ||
                              val == '  ' ||
                              val == '   ' ||
                              val == '    ') {
                            return 'Please enter valid City Name';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          return cityController.text = val.toString();
                        },
                        onChanged: (val) {
                          setState(() {
                            disabledButton = false;
                          });
                          return null;
                        },
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //         border: Border.all(
                    //             width: 1.0, color: AppColors.primary)),
                    //     child: TextButton(
                    //         onPressed: () {
                    //           // changePasswordModal();
                    //         },
                    //         child: const TitleFont(
                    //           text: 'Change Password',
                    //           size: 20,
                    //           color: AppColors.primary,
                    //         )),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    FractionallySizedBox(
                        widthFactor: 1,
                        child: ElevatedButton(
                            onPressed: disabledButton
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        // auth != auth;
                                      });

                                      // address!.id = widget.addressId;
                                      // address!.street = streetAddressController.text;
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.TOPSLIDE,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.success,
                                        showCloseIcon: true,
                                        title: 'You  agent request is send !',
                                        desc: 'You will come back soon ',
                                        btnOkOnPress: () {
                                          Navigator.of(context).pop();
                                        },
                                        btnOkIcon: Icons.check_circle,
                                        btnOkText: 'Ok',
                                        btnCancelOnPress: () {},
                                        btnCancelIcon: Icons.cancel,
                                        onDismissCallback: (type) {
                                          print(
                                              'Dialog Dissmiss from callback $type');
                                        },
                                      ).show();
                                    }
                                    ProductsRegistration(
                                        latitude: '', longitude: '');
                                  },
                            child: const Text('Become An Agent'))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
