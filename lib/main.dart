//import 'package:betdelalamobile/providers/products_screen.dart';
// @dart=2.9

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:betdelalamobile/acounts/login.dart';
import 'package:betdelalamobile/acounts/register.dart';
import 'package:betdelalamobile/agent/agent_registration.dart';
import 'package:betdelalamobile/model/Products.dart';
import 'package:betdelalamobile/providers/auth.dart';
import 'package:betdelalamobile/providers/cart.dart';
import 'package:betdelalamobile/providers/house_product_list.dart';
import 'package:betdelalamobile/providers/orders.dart';
import 'package:betdelalamobile/providers/products_user.dart';
import 'package:betdelalamobile/providers/recommanded_house_provider.dart';
//import 'package:betdelalamobile/providers/recommand_product_provider.dart';
import 'package:betdelalamobile/providers/search_loadouts.dart';
import 'package:betdelalamobile/screens/cart_screen.dart';
import 'package:betdelalamobile/screens/map_screen.dart';
import 'package:betdelalamobile/screens/order_screen.dart';
import 'package:betdelalamobile/screens/products_screen.dart';

import 'package:betdelalamobile/widget/favourite_product.dart';
import 'package:betdelalamobile/widget/product_grid.dart';
import 'package:betdelalamobile/widget/user_product.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
              create: (_) => Products('', '', []),
              update: ((context, value, previous) {
                return Products(
                  value.token,
                  value.pid,
                  previous == null ? [] : previous.items,
                );
              })),
          ChangeNotifierProvider.value(
            value:
                SearchLoadouts(), //build cars widget (providing list of cars)
          ),
          ChangeNotifierProvider.value(
            value:
                HouseProductList(), //build cars widget (providing list of cars)
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
              create: (_) => Orders('', '', []),
              update: ((context, value, previous) {
                return Orders(
                  value.token,
                  value.pid,
                  previous == null ? [] : previous.orders,
                );
              })),
          ChangeNotifierProvider.value(
            value:
                RecommandedHouses(), //build cars widget (providing list of cars)
          ),
          ChangeNotifierProvider.value(
            value: Product(), //build cars widget (providing list of cars)
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Zedelala',
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
                  .copyWith(secondary: Colors.deepOrange)
                  .copyWith(
                      //primarySwatch: Colors.indigo,
                      secondary: Colors.deepOrange),
            ),
            home: auth.isAuth ? const ProductScreen() : const LoginScreen(),
            routes: {
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              ProductScreen.routename: (context) => const ProductScreen(),
              ProductGrid.routeName: ((context) => const ProductGrid()),
              MapScreen.routeName: ((context) => MapScreen()),
              RegisterScreen.routeName: ((context) => const RegisterScreen()),
              Favourite.routeName: (context) => Favourite(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              AgentRegistration.routename: (context) => AgentRegistration(),
              // ProductRegistration.routeName: (context) =>
              //     ProductRegistration(latitude: '', longitude: '')
            },
          ),
        ));
  }
}
