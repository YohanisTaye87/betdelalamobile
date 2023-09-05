import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../acounts/login.dart';
import '../theme/colors.dart';
import '../widget/post_registration_dialogue.dart';
import '../widget_functions/style.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class Utility {
  String backendUrl = '';
  // String backendUrl = 'https://deliver-app-dev-9h44m.ondigitalocean.app';
  int timeOut = 15;

  double responsive(BuildContext context, double size) {
    final deviceSize = MediaQuery.of(context).size.width;
    if (deviceSize > 380) {
      return size;
    } else {
      return size;
    }
  }

  void bottomModal(BuildContext context, Widget widget) async {
    // final deviceSize = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        isScrollControlled: true,
        elevation: 5,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          );
        });
  }

  Color OrderColor(String status) {
    if (status == 'REQUESTED') {
      return const Color.fromARGB(150, 33, 149, 243);
    }
    if (status == 'ACCEPTED') {
      return const Color.fromARGB(150, 76, 175, 79);
    }
    if (status == 'READY_FOR_PICKUP') {
      return const Color.fromARGB(150, 255, 235, 59);
    }
    if (status == 'PICKED_UP') {
      return const Color.fromARGB(148, 255, 157, 239);
    }
    if (status == 'CONFIRMED') {
      return const Color.fromARGB(149, 186, 255, 59);
    }
    if (status == 'CANCELED') {
      return const Color.fromARGB(150, 255, 82, 82);
    }
    if (status == 'AGENT_ACCEPTED') {
      return const Color.fromARGB(148, 82, 85, 255);
    }
    if (status == 'NOT_DELIVERED') {
      return const Color.fromARGB(149, 255, 82, 82);
    }
    if (status == 'DELIVERED') {
      return const Color.fromARGB(149, 82, 255, 218);
    }
    if (status == 'DROPPED') {
      return const Color.fromARGB(147, 50, 88, 81);
    } else {
      return const Color.fromARGB(149, 250, 250, 250);
    }
  }

  Color orderStatusFontColor(String status) {
    if (status == 'READY_FOR_PICKUP' || status == 'DELIVERED') {
      return AppColors.black;
    } else {
      return AppColors.white;
    }
  }

  bool isNullOrBlank(String? data) => data?.trim().isEmpty ?? true;

  double appFontSize(String type) {
    if (type == '1t') {
      return 23;
    }
    if (type == '2t') {
      return 20;
    }
    if (type == '3t') {
      return 18;
    }
    if (type == '3.5t') {
      return 17;
    }
    if (type == '4t') {
      return 16;
    }
    if (type == '5t') {
      return 14.5;
    }
    if (type == '6t') {
      return 13.5;
    } else {
      return 15;
    }
  }

  String orderStatus(String status) {
    if (status == 'REQUESTED') {
      return 'Requested';
    }
    if (status == 'ACCEPTED') {
      return 'Accepted';
    }
    if (status == 'READY_FOR_PICKUP') {
      return 'Ready for pickup';
    }
    if (status == 'CONFIRMED') {
      return 'Confirmed';
    }
    if (status == 'CANCELED') {
      return 'Canceled';
    }
    if (status == 'NOT_DELIVERED') {
      return 'Not delivered';
    }
    if (status == 'DELIVERED') {
      return 'Delivered';
    }
    if (status == 'AGENT_ACCEPTED') {
      return 'Agent accepted';
    }
    if (status == 'PICKED_UP') {
      return 'Picked up';
    }
    if (status == 'DROPPED') {
      return 'Dropped';
    } else {
      return '';
    }
  }

  scaffoldMessage(BuildContext context, String message, Color bkgrdClr) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1700),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: bkgrdClr,
    ));
  }

  Future<void> loading(String status) async {
    await EasyLoading.show(
        indicator: const MoreLoadingGif(
          type: MoreLoadingGifType.ripple,
          size: 50,
        ),
        dismissOnTap: false,
        status: status,
        maskType: EasyLoadingMaskType.black);
  }

  Future<void> callNow(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  loginRequestDialogue(context, String title, String descripton) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.INFO,
      showCloseIcon: true,
      title: title,
      desc: descripton,
      btnOkOnPress: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen()));
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

  void showSuccessDialog(context, title) async {
    final deviceWidth = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
                height: deviceWidth > 380
                    ? MediaQuery.of(context).size.height * 0.45
                    : MediaQuery.of(context).size.height * 0.6,
                width: deviceWidth * 0.75,
                child: PostRegistrationDialogue(
                  title: title,
                )),
          );
        });
  }

  void aboutDialogue(BuildContext context) async {
    final info = await PackageInfo.fromPlatform();

    showAboutDialog(
        useRootNavigator: false,
        applicationLegalese:
            'Esoora Food Delivery app is developed by ethioClicks® PLC all rights reserved 2023.',
        // 'This version is for testing purpose only! \nEC Food Delivery app is developed by EthioClicks® Technologies all rights reserved 2022.',
        context: context,
        applicationIcon: const CircleAvatar(
          backgroundColor: AppColors.transparent,
          backgroundImage: AssetImage('assets/esoora_logo.png'),
        ));
  }

  void willPopDialogue(context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.INFO,
      showCloseIcon: true,
      title: 'Are you sure you want to leave?',
      desc: 'Any change will be discarded!',
      buttonsTextStyle: const TextStyle(fontSize: 14, color: AppColors.white),
      btnOkOnPress: () {
        Navigator.of(context).pop();
      },
      btnCancelColor: AppColors.secondary,
      btnOkColor: AppColors.primary,
      btnOkIcon: Icons.check,
      btnOkText: 'Confirm',
      btnCancelOnPress: () {},
      btnCancelIcon: Icons.cancel,
      btnCancelText: 'Cancel',
      onDismissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
    ).show();
  }

  void contactDialogue(context) async {
    final deviceWidth = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.transparent,
                        backgroundImage: AssetImage('assets/esoora_logo.png'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 60,
                        child: Image(
                          image: AssetImage('assets/ethioclickslogo.png'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitleFont(
                    text: 'ethioClicks PLC',
                    size: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const DescriptionFont(text: 'Phone: '),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        callNow('+251947707075');
                      },
                      child: DescriptionFont(
                        text: '+251947707075',
                        size: deviceWidth > 380 ? 13 : 12,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const DescriptionFont(text: 'Email: '),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        launch(
                            'mailto:ethioclick2020@gmail.com?subject=Esoora Food Delivery App Title&body=Esoora');
                      },
                      child: DescriptionFont(
                        text: 'info@ethioclicks.com',
                        size: deviceWidth > 380 ? 13 : 12,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const DescriptionFont(text: 'Address: '),
                  const SizedBox(
                    height: 5,
                  ),
                  DescriptionFont(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: 'Piassa, Sekka Tower 11th floor, Addis Ababa',
                    color: AppColors.secondary,
                    size: deviceWidth > 380 ? 13 : 12,
                  ),
                ],
              )),
            ),
          );
        });
  }

  // Future<void> resetCart(BuildContext context) async {
  //   DBHelper dbHelper = DBHelper();
  //   final provider = Provider.of<CartProvider>(context, listen: false);
  //   provider.removeAll();
  //   await dbHelper.deleteAllItems();
  // }

  // hideKeyboard(BuildContext context) {
  //   FocusScope.of(context).requestFocus(FocusNode());
  // }
}
