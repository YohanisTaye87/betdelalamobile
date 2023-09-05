import 'package:betdelalamobile/acounts/login.dart';
import 'package:betdelalamobile/providers/auth.dart';
import 'package:betdelalamobile/screens/new_product.dart';
import 'package:betdelalamobile/screens/search_screen.dart';
import 'package:betdelalamobile/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../widget/product_grid.dart';

class LoginScreenArgs {
  bool isSelected = false;
  bool isOnline;
  String? encodedPts;

  LoginScreenArgs({required this.isOnline});
}

class ProductScreen extends StatefulWidget {
  static const routename = '/product';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _pages = [
      {
        'page': const ProductGrid(),
      },
      {
        'page': SearchScreen(),
      },
      {'page': const NewProduct()},
      {'page': const LoginScreen()},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isAuth = Provider.of<Auth>(context).isAuth;
    print(isAuth);
    return Scaffold(
      body: _selectedIndex == 3
          ? isAuth == true
              ? UserProfile()
              : const LoginScreen()
          : _pages[_selectedIndex]['page'] as Widget,
      bottomNavigationBar: GNav(
          tabMargin: const EdgeInsets.fromLTRB(10, 5, 15, 0),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: Colors.grey.shade300,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.black,
          tabBorderRadius: 70.00,
          iconSize: 25,
          gap: 10.0,
          padding: const EdgeInsets.all(12),
          onTabChange: _selectPage,
          //curve: Curves.easeInCirc,
          // ignore: prefer_const_literals_to_create_immutables
          tabs: [
            const GButton(
              icon: Icons.home,
            ),
            const GButton(
              icon: Icons.search,
            ),
            const GButton(
              icon: Icons.new_releases_outlined,
            ),
            const GButton(
              icon: Icons.account_circle,
            )
          ]),
    );
  }
}
