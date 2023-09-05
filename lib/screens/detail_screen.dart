// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:betdelalamobile/providers/recommanded_house_provider.dart';
import 'package:betdelalamobile/providers/search_loadouts.dart';
import 'package:betdelalamobile/screens/recommanded_house_screen.dart';
import 'package:betdelalamobile/widget_file/detail_form.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/house_detail.dart';
import '../model/house_list_model.dart';

//import '../model/property_recommanded_list_model.dart';

import 'package:provider/provider.dart';

//import '../providers/recommand_product_provider.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({required this.productUid, required this.id});
  final String productUid;
  final int id;
  var _isloading;
//  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String features = '';
  int activeIndex = 0;
  static final RegExp REGEX_EMOJI = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
  final CarouselController _controller = CarouselController();
  final value = NumberFormat("#,##0.00",
      "en_US"); // a variables used to format a number in correct format
  Future<DetailHouseList?>? houseDetail;
  Future<PropertyListModel?>? recommandedHouseDetail;
  List<Content> searchResult = [];

  @override
  void didChangeDependencies() {
    houseDetail =
        Provider.of<SearchLoadouts>(context).getData(widget.productUid);
    Provider.of<RecommandedHouses>(context, listen: false)
        .getRecommandedData(widget.id.toString())
        .then((_) {
      setState(() {
        widget._isloading = false;
      });
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  _launchInBrowser(Uri url) {
    launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<DetailHouseList?>(
          future: houseDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var detailProperty = snapshot.data;
              int len = detailProperty!.propertyImagesList.length;
              print(MediaQuery.of(context).padding.top);
              print(MediaQuery.of(context).size.height);
              String convertUTF8(String value) {
                var filterdtext = value.replaceAll(REGEX_EMOJI, '!');
                var utf8Runes = filterdtext.runes.toList();
                return const Utf8Decoder(allowMalformed: true)
                    .convert(utf8Runes);
              }

              for (int i = 0;
                  i < detailProperty.propertyFeaturesList.length;
                  i++) {
                features += detailProperty.propertyFeaturesList[i].name +
                    (i + 1 == detailProperty.propertyFeaturesList.length
                        ? ''
                        : ', ');
              }
              return Container(
                  height: double.infinity,
                  width: double.infinity,
                  // ignore: prefer_const_constructors
                  margin: EdgeInsets.fromLTRB(
                      5, MediaQuery.of(context).padding.top, 5, 0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            alignment: Alignment.topRight,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (final states) => states.contains(
                                                MaterialState.disabled)
                                            ? Colors.indigo
                                            : Color(0xFF661F1F)),
                              ),
                              onPressed: () {
                                _launchInBrowser(Uri.parse(
                                    "https://www.linkedin.com/in/yohanis-taye-8ab855245/"));
                              },
                              child: const Text(
                                'Contact Agent',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )),
                        Container(
                          child: Stack(children: [
                            CarouselSlider.builder(
                              itemCount:
                                  detailProperty.propertyImagesList.length,
                              options: CarouselOptions(
                                  height: deviceSize.height * 0.3,
                                  autoPlay: false,
                                  viewportFraction: 1,
                                  onPageChanged: ((index, reason) {
                                    setState(() {
                                      activeIndex = index;
                                    });
                                  })),
                              itemBuilder: ((context, index, realIndex) {
                                return SizedBox(
                                    //height: deviceSize.height*0.2,
                                    width: deviceSize.width,
                                    child: Image.network(
                                      snapshot
                                          .data!.propertyImagesList[index].url,
                                      fit: BoxFit.cover,
                                    ));
                              }),
                            ),
                            Positioned(
                              right: 3,
                              top: 1,
                              child: Container(
                                  width: deviceSize.width * 0.20,
                                  height: deviceSize.width * 0.06,
                                  // padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(color: Colors.black54
                                        // blurRadius: 15.0, // soften the shadow
                                        //spreadRadius: 5.0, //extend the shadow

                                        )
                                  ]),
                                  child: Text(
                                    'For ${detailProperty.enumContractType}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  )),
                            ),
                            Positioned(
                              //left: 10,
                              right: 50,
                              left: 50,
                              bottom: 5,
                              child: Container(
                                // decoration: BoxDecoration(
                                //   boxShadow: [
                                //     BoxShadow(
                                //       color: Colors.black54
                                //     )
                                //   ]
                                // ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: detailProperty.propertyImagesList
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 10.0,
                                        height: 10.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 0.2, horizontal: 6.0),
                                        decoration: BoxDecoration(
                                            // ignore: prefer_const_literals_to_create_immutables

                                            shape: BoxShape.circle,
                                            color:
                                                (Theme.of(context).brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.white)
                                                    .withOpacity(
                                                        activeIndex == entry.key
                                                            ? 0.9
                                                            : 0.4)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Text(
                                '${value.format(detailProperty.price)} ${detailProperty.enumCurrencyType}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.007,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            '${detailProperty.bedrooms}bds | ${detailProperty.bathrooms}ba |${value.format(detailProperty.area)} sq m',
                            style: const TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.007,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            '${detailProperty.addressLookups!.subCity}, ${detailProperty.addressLookups!.city}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                            //textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.02,
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Specification',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(
                          height: deviceSize.height * 0.01,
                        ),
                        Card(
                            borderOnForeground: true,
                            semanticContainer: true,
                            //elevation: 10,
                            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                            //shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                side: BorderSide(
                                    color: Colors.grey.shade100, width: 3)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DetailForm(
                                  dataValue: snapshot.data!.yearBuilt,
                                  value: 'Year Built ',
                                ),
                                DetailForm(
                                  dataValue: 'House',
                                  value: 'Type ',
                                ),
                                DetailForm(
                                  dataValue: '${detailProperty.area} sq meter',
                                  value: 'Size ',
                                ),
                                DetailForm(
                                  dataValue: '${detailProperty.bathrooms} ',
                                  value: 'Bath ',
                                ),
                                DetailForm(
                                  dataValue: '${detailProperty.parkingSpace} ',
                                  value: 'Garages ',
                                ),
                                DetailForm(
                                  dataValue: features.isEmpty ? '' : features,
                                  value: 'Features ',
                                ),
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                            child: const Text(
                              'Description :',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 3, 0, 3),
                          child: Text(
                            ' ${convertUTF8(detailProperty.description)}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                            width: deviceSize.width,
                            height: deviceSize.height * 0.5,
                            child: RecommandedHousesScreen())
                      ],
                    ),
                  ));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
