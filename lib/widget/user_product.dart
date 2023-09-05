import 'package:betdelalamobile/providers/auth.dart';
import 'package:betdelalamobile/providers/products_user.dart';
import 'package:betdelalamobile/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  Future<Product>? house;

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<HouseProductList>(context);
    var deviceSize = MediaQuery.of(context).size;
    var auth = Provider.of<Auth>(context, listen: false).isAuth;
    print(auth);
    //final productsData = Provider.of<HouseProductList>(context);
    //final products = productsData.items;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: const <Widget>[
            // auth == true
            //     ? IconButton(
            //         icon: const Icon(Icons.add),
            //         onPressed: () {
            //           // Navigator.of(context)
            //           //     .pushNamed(ProductRegistration.routeName);
            //         },
            //       )
            //     : const Text('')
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Consumer<Products>(
                        builder:
                            (context, productData, child) =>
                                SingleChildScrollView(
                                    //primary: true,

                                    scrollDirection: Axis.vertical,
                                    physics: const ScrollPhysics(),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          // SizedBox(
                                          //   height: deviceSize.height * 0.5,
                                          //   width: deviceSize.width,
                                          //   child: const FeaturedProduct(),
                                          // ),
                                          Container(
                                            height: deviceSize.height * 6.4,
                                            padding: const EdgeInsets.fromLTRB(
                                                2, 15, 0, 0),
                                            child: Card(
                                              elevation: 20,
                                              borderOnForeground: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 10,
                                                          color: Colors.white)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    width: double.infinity,
                                                    child: const Text(
                                                      ' ',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    //child: Text(snapshot.data!.beds),
                                                    child: ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: productData
                                                            .items.length,
                                                        //scrollDirection: Axis.vertical,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Column(
                                                                    children: [
                                                                      ListTile(
                                                                        title: Text(productData
                                                                            .items[index]
                                                                            .ProductName),
                                                                        leading:
                                                                            const CircleAvatar(
                                                                          backgroundImage:
                                                                              NetworkImage('https://github.com/sebagadisk/Images/blob/BetDelala/No%20Image.png?raw=true'),
                                                                        ),
                                                                        trailing:
                                                                            SizedBox(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              Row(
                                                                            children: <Widget>[
                                                                              IconButton(
                                                                                icon: const Icon(Icons.edit),
                                                                                onPressed: () {
                                                                                  // print(productData.items[index].StreetAdrress);
                                                                                  // Navigator.of(context).pushNamed(ProductRegistration.routeName, arguments: productData.items[index].id);
                                                                                },
                                                                                color: Theme.of(context).primaryColor,
                                                                              ),
                                                                              IconButton(
                                                                                icon: const Icon(Icons.delete),
                                                                                onPressed: () async {
                                                                                  try {
                                                                                    await Provider.of<Products>(context, listen: false).deleteProduct(productData.items[index].id, context);
                                                                                  } catch (error) {
                                                                                    print(error);
                                                                                    const Dialog(
                                                                                      child: Text(
                                                                                        'Deleting failed!',
                                                                                        textAlign: TextAlign.center,
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                                color: Theme.of(context).errorColor,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ])),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ])),
                      ),
                    ),
        ));
    // efreshIndicator(
    //   onRefresh: () => _refreshProducts(context),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8),
    //     child: ListView.builder(
    //       itemCount: productsData.items.length,
    //       itemBuilder: (_, i) => Column(
    //         children: [
    //           UserProductItem(
    //             productsData.items[i].id,
    //             productsData.items[i].title,
    //             productsData.items[i].imageUrl,
    //           ),
    //           const Divider(),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
  }
}
