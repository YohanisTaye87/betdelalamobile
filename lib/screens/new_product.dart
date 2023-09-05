import 'package:betdelalamobile/acounts/login.dart';
import 'package:betdelalamobile/providers/products_user.dart';
import 'package:betdelalamobile/screens/cart_screen.dart';
import 'package:betdelalamobile/screens/detail_new_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Products.dart';
import '../providers/auth.dart';
import '../providers/cart.dart';
import '../widget/app_drawer.dart';
import '../widget/badge.dart';

enum FilterOptions {
  Favorites,
  All,
}

class NewProduct extends StatefulWidget {
  const NewProduct({super.key});

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  var _isInit = true;
  var _isLoading = false;
  var _showOnlyFavorites = false;
  final value = NumberFormat("#,##0.00", "en_US");
  //Future<Product?>? PostedHouseList;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    final productsData = Provider.of<Products>(context);
    final products =
        _showOnlyFavorites ? productsData.favoriteItems : productsData.items;
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: FilterOptions.Favorites,
                  child: Text('Only Favorites'),
                ),
                const PopupMenuItem(
                  value: FilterOptions.All,
                  child: Text('Show All'),
                ),
              ],
            ),
            Consumer<Cart>(
                builder: (_, cart, ch) => Badge(
                      value: cart.itemCount.toString(),
                      color: Colors.blue,
                      child: ch as Widget,
                    ),
                child: IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      authData.isAuth
                          ? Navigator.of(context)
                              .pushNamed(CartScreen.routeName)
                          : Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                      //Scaffold.of(context).

                      SnackBar(
                        content: const Text(
                          'Added item to cart!',
                        ),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            cart.removeSingleItem(products[1].id);
                          },
                        ),
                      );
                    }))
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                //primary: true,

                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  // SizedBox(
                  //   height: deviceSize.height * 0.5,
                  //   width: deviceSize.width,
                  //   child: const FeaturedProduct(),
                  // ),
                  Container(
                      height: deviceSize.height * 11,
                      padding: const EdgeInsets.fromLTRB(2, 15, 0, 0),
                      child: Card(
                          elevation: 20,
                          borderOnForeground: true,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(width: 10, color: Colors.white)),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  width: double.infinity,
                                  child: const Text(
                                    'Trended  posted Houses  ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: products.length,
                                        //scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (context, index) =>
                                                ChangeNotifierProvider.value(
                                                    value: products[index],
                                                    child: products.isNotEmpty
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              //print(products[index].id);
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                      MaterialPageRoute(
                                                                builder: (_) =>
                                                                    DetailNewScreen(
                                                                  id: products[
                                                                          index]
                                                                      .id,
                                                                ),
                                                              ));
                                                            },
                                                            child: Container(
                                                              width: deviceSize
                                                                      .width *
                                                                  0.23,
                                                              height: deviceSize
                                                                      .height *
                                                                  0.35,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        10,
                                                                        8),
                                                                child: Card(
                                                                  semanticContainer:
                                                                      true,
                                                                  elevation: 10,
                                                                  borderOnForeground:
                                                                      true,
                                                                  shape: const RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          width:
                                                                              10,
                                                                          color:
                                                                              Colors.white)),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                          alignment: Alignment
                                                                              .topRight,
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              0,
                                                                              10,
                                                                              10,
                                                                              0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              IconButton(
                                                                                  icon: const Icon(
                                                                                    color: Colors.blue,
                                                                                    Icons.shopping_cart,
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    authData.isAuth ? cart.addItem(products[index].id, 12000, products[index].ProductName) : Navigator.of(context).pushNamed(LoginScreen.routeName);
                                                                                    //Scaffold.of(context).

                                                                                    SnackBar(
                                                                                      content: const Text(
                                                                                        'Added item to cart!',
                                                                                      ),
                                                                                      duration: const Duration(seconds: 2),
                                                                                      action: SnackBarAction(
                                                                                        label: 'UNDO',
                                                                                        onPressed: () {
                                                                                          cart.removeSingleItem(products[1].id);
                                                                                        },
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                              const Icon(
                                                                                Icons.location_on,
                                                                                size: 15,
                                                                              ),
                                                                              Text(
                                                                                products[index].StreetAdrress,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 1,
                                                                                style: const TextStyle(
                                                                                  color: Colors.indigo,
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                      Expanded(
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Card(
                                                                              child: Container(
                                                                                decoration: const BoxDecoration(
                                                                                  image: DecorationImage(image: NetworkImage('https://github.com/sebagadisk/Images/blob/BetDelala/No%20Image.png?raw=true'), fit: BoxFit.cover),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Positioned(
                                                                              right: 11,
                                                                              top: 5,
                                                                              child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  width: deviceSize.width * 0.2,
                                                                                  height: deviceSize.height * 0.023,
                                                                                  decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Colors.black54)]),
                                                                                  child: Text(
                                                                                    '${products[index].selectedPropertyType}',
                                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                                                                  )),
                                                                            ),
                                                                            Positioned(
                                                                              //top: 0,
                                                                              bottom: 0,
                                                                              left: 0,
                                                                              right: 0,
                                                                              child: Container(
                                                                                padding: const EdgeInsets.fromLTRB(10, 10, 4, 10),
                                                                                color: Colors.white,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Text(
                                                                                      '1,000,000,000 ${'Birr'}',
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        color: Colors.teal.shade600,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                    )),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        '${products[index].beds}bds, ${products[index].garage}gar, 250 sq',
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        maxLines: 1,
                                                                                        style: const TextStyle(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          color: Color.fromRGBO(0, 0, 0, 0.541),
                                                                                          fontSize: 14,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Consumer<Product>(
                                                                                      builder: (context, product, child) => IconButton(
                                                                                        icon: Icon(
                                                                                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                                                                                        ),
                                                                                        color: Theme.of(context).colorScheme.secondary,
                                                                                        onPressed: () {
                                                                                          print(authData.token);
                                                                                          print(authData.pid);

                                                                                          authData.isAuth
                                                                                              ? product.toggleFavoriteStatus(
                                                                                                  authData.token,
                                                                                                  authData.pid,
                                                                                                )
                                                                                              : Navigator.of(context).pushNamed(LoginScreen.routeName);
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ))))
                              ])))
                ])));
  }
}
