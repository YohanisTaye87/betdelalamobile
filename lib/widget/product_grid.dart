// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:betdelalamobile/acounts/login.dart';
import 'package:betdelalamobile/model/house_list_model.dart';
import 'package:betdelalamobile/providers/auth.dart';
import 'package:betdelalamobile/widget/add_edit_product.dart';
import 'package:betdelalamobile/widget/app_drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:provider/provider.dart';

import '../providers/house_product_list.dart';
import '../screens/detail_screen.dart';
import '../theme/colors.dart';
import 'featured_product.dart';

class ProductGrid extends StatefulWidget {
  static const routeName = '/product-grid';
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  bool isLoadMoreRunning = false,
      isLoadMoreRunningA = false,
      hasNextPage = true,
      hasNextPageA = true;
  ScrollController scrollController = ScrollController();
  int page = 0, size = 18;
  late Future<PropertyListModel?>? PostedHouseList;
  final value = NumberFormat("#,##0.00", "en_US");
  // a variables used to format a number in correct format
  @override
  void initState() {
    super.initState();
    Provider.of<HouseProductList>(context, listen: false)
        .getFeaturedHouseList()
        .then((value) {
      setState(() {});
    });
    fetch();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void fetch() async {
    page = 1;

    hasNextPage = true;
    hasNextPageA = true;
    isLoadMoreRunning = false;
    isLoadMoreRunningA = false;
    PostedHouseList = getdata(context);
    scrollController = ScrollController()..addListener(loadMore);
  }

  Future<PropertyListModel> getdata(ctx) async {
    //print(scrollController.position.extentAfter);
    try {
      var uri =
          'https://sea-turtle-app-j4ksa.ondigitalocean.app/public/property-list?page=$page&size=18&sort=publishedTime,DESC';
      //final extracteddata = json.decode(response.body) as Map<String, dynamic>;
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return PropertyListModel.fromJson(jsonResponse);
      } else {
        print('invalid response recived');
      }
    } catch (error) {
      print('This is an error :$error');
    }
    throw 'Unexpected Error Occured! Please try again.';
  }

  Future<PropertyListModel?>? loadMore() async {
    return PostedHouseList!.then((value) async {
      if (hasNextPage == true) {
        if (isLoadMoreRunning == false &&
            scrollController.position.extentAfter < 300) {
          setState(() {
            isLoadMoreRunning = true;
          });
          page += 1;
          final url = Uri.parse(
              'https://sea-turtle-app-j4ksa.ondigitalocean.app/public/property-list?page=$page&size=18&sort=publishedTime,DESC');
          try {
            final response = await http.get(
              url,
            );
            if (response.statusCode == 200) {
              final moredata =
                  PropertyListModel.fromJson(jsonDecode(response.body));
              if (moredata.last == true) {
                setState(() {
                  isLoadMoreRunning = false;
                  hasNextPage = false;
                  return value!.content.addAll(moredata.content);
                });
              } else {
                setState(() {
                  isLoadMoreRunning = false;
                  return value!.content.addAll(moredata.content);
                });
              }
            } else {
              setState(() {
                isLoadMoreRunning = false;
                hasNextPage = false;
              });
              return null;
            }
          } on TimeoutException {
            setState(() {
              isLoadMoreRunning = false;
            });
            throw 'Network is timedout please try again.';
          } on SocketException {
            setState(() {
              isLoadMoreRunning = false;
            });
            throw 'Network is unreachable! Please check your internet connection.';
          }
        }
      } else {
        hasNextPage = false;
        isLoadMoreRunning = false;
      }
      return null;
    });
  }

  @override
  void didChangeDependencies() {
    // Provider.of<HouseProductList>(context, listen: false).houseProductList =
    //     Provider.of<HouseProductList>(context, listen: false).getdata();
    // Provider.of<HouseProductList>(context, listen: false).scrollController =
    //     ScrollController()
    //       ..addListener(
    //           Provider.of<HouseProductList>(context, listen: false).loadmore);

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Widget postedCard(List<Content> data, index) {
    var deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print(data[index].publicId);
        print(data[index].id);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetailScreen(
            productUid: data[index].publicId,
            id: data[index].id,
          ),
        ));
      },
      child: Container(
        width: deviceSize.width * 0.23,
        height: deviceSize.height * 0.35,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
          child: Card(
            semanticContainer: true,
            elevation: 10,
            borderOnForeground: true,
            shape: const RoundedRectangleBorder(
                side: BorderSide(
                    style: BorderStyle.solid, width: 10, color: Colors.white)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.remove_red_eye_sharp,
                            size: 17,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          // Text(
                          //   '${data[index].impression}',
                          //   style: const TextStyle(fontSize: 15,
                          //   fontWeight: FontWeight.normal
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 15,
                              ),
                              Text(
                                '${data[index].addressLookups!.city}, ${data[index].addressLookups!.subCity}',
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
                    ),
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      data[index].propertyImagesList.isEmpty
                          ? Card(
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://github.com/sebagadisk/Images/blob/BetDelala/No%20Image.png?raw=true'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            )
                          : Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          data[index].propertyImagesList[0].url
                                            ..isEmpty),
                                      fit: BoxFit.cover),
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
                            decoration: const BoxDecoration(
                                boxShadow: [BoxShadow(color: Colors.black54)]),
                            child: Text(
                              'For ${data[index].enumContractType}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
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
                                  '${value.format(data[index].price)} ${data[index].enumCurrencyType}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.teal.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${data[index].bedrooms}bds, ${data[index].bathrooms}ba,${value.format(data[index].area)} sq m',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, 0.541),
                                    fontSize: 14,
                                  ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<Auth>(context, listen: false).isAuth);
    var deviceSize = MediaQuery.of(context).size;
    //super.build(context);
    if (scrollController.hasClients) {
      print('yess');
    }

    print(deviceSize.height);
    // final recommendedList = Provider.of<Houses>(context).getdata();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.secondary, // <-- SEE HERE
          statusBarIconBrightness:
              Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.light, //<-- For iOS SEE HERE (dark icons)
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          tooltip: 'Register House',
          onPressed: () async {
            if (Provider.of<Auth>(context, listen: false).isAuth == true) {
              
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProductsRegistration(
                        latitude: '',
                        longitude: '',
                      )));
            } else {
              Provider.of<Auth>(context,listen: false)
                  .loginEnforceDialogue(context, 'To register a house', false);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const LoginScreen()));
            }
          },
          icon: SvgPicture.asset(
            'assets/icons/add-plus-svgrepo-com.svg',
            width: 30,
          ),
        ),
      ),
      //drawer: AppDrawer(),
      body: FutureBuilder<PropertyListModel?>(
          future: PostedHouseList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              final error = snapshot.error;
            }
            if (snapshot.hasData) {
              PropertyListModel? data = snapshot.data;
              if (data!.empty == true) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const Center(
                      child: Text(
                    'No house is available!',
                  )),
                );
              }

              return SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      height: deviceSize.height * 0.5,
                      width: deviceSize.width,
                      child: const FeaturedProduct(),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Card(
                          elevation: 20,
                          borderOnForeground: true,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(width: 10, color: Colors.white)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  width: double.infinity,
                                  child: const Text(
                                    'New posted Houses  ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Flexible(
                                //flex: 18,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    //controller: scrollController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data.content.length,
                                    itemBuilder: (context, index) {
                                      return postedCard(data.content, index);
                                    }),
                              ),
                              if (isLoadMoreRunning == true)
                                const Flexible(
                                  //flex: 1,
                                  child: Center(
                                    child: MoreLoadingGif(
                                      type: MoreLoadingGifType.ellipsis,
                                      size: 30,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]));
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
