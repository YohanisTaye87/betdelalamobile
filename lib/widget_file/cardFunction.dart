import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/house_list_model.dart';
import '../screens/detail_screen.dart';

class CardsFunctions extends StatefulWidget {
  List<Content> CardProductList;
  var CardTitle;

  CardsFunctions({required this.CardProductList, required this.CardTitle});
  @override
  State<CardsFunctions> createState() => _CardsFunctionsState();
}

class _CardsFunctionsState extends State<CardsFunctions> {
  final value = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      height: deviceSize.height * 0.6,
      padding: const EdgeInsets.fromLTRB(1, 0, 0, 5),
      child: Card(
        //color: Colors.white,
        //elevation: 10,
        borderOnForeground: true,
        shape: const RoundedRectangleBorder(
            side: BorderSide(width: 10, color: Colors.white)),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              width: double.infinity,
              child: Text(
                widget.CardTitle,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.CardProductList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // print('${fetchedContent[index].publicId}');
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DetailScreen(
                              productUid:
                                  widget.CardProductList[index].publicId,
                              id: widget.CardProductList[index].id,
                            ),
                          ));
                        },
                        child: Container(
                            width: deviceSize.width * 0.78,
                            height: deviceSize.height * 0.5,
                            //margin: const EdgeInsets.only(right: 3),
                            //padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              // border: Border(
                              //     right: BorderSide(
                              //         width: 1, color: Colors.black)),
                              color: Colors.white,
                              //borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
                              child: Card(
                                semanticContainer: true,
                                //shadowColor: Colors.grey,
                                elevation: 10,
                                borderOnForeground: true,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 8,
                                        color: Colors.white)),
                                child: Stack(
                                  children: [
                                    widget.CardProductList.isEmpty
                                        ? Container(
                                            child:
                                                const CircularProgressIndicator(),
                                          )
                                        : Card(
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                // border: const Border(
                                                //     bottom: BorderSide(width: 10)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        //scale: 3/4,
                                                        widget
                                                            .CardProductList[
                                                                index]
                                                            .propertyImagesList[
                                                                0]
                                                            .url),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                          ),
                                    Positioned(
                                      right: 12,
                                      top: 12,
                                      child: Container(
                                          width: deviceSize.width * 0.2,
                                          height: deviceSize.height * 0.025,
                                          // padding: const EdgeInsets.all(5),
                                          decoration:
                                              const BoxDecoration(boxShadow: [
                                            BoxShadow(color: Colors.black54
                                                // blurRadius: 15.0, // soften the shadow
                                                //spreadRadius: 5.0, //extend the shadow

                                                )
                                          ]),
                                          child: Text(
                                            'For ${widget.CardProductList[index].enumContractType}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white),
                                          )),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        //margin: EdgeInsets.only(bottom: 50),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 25),
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${value.format(widget.CardProductList[index].price)} ${widget.CardProductList[index].enumCurrencyType}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    //color: Colors.green,
                                                    color: Colors.teal.shade600,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  '${widget.CardProductList[index].bedrooms}bds, ${widget.CardProductList[index].bathrooms}ba,${value.format(widget.CardProductList[index].area)} sq m',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.541),
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    '${widget.CardProductList[index].addressLookups!.city}, ${widget.CardProductList[index].addressLookups!.subCity}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ]),
                                              ],
                                            ),
                                            Card(
                                                elevation: 6,
                                                clipBehavior: Clip.antiAlias,
                                                shadowColor: Colors.grey,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                    colors: [
                                                      Colors.black,
                                                      Colors.black45,
                                                    ],
                                                    //begin: Alignment.topRight,
                                                    // end: Alignment
                                                    //     .topLeft
                                                  )),
                                                  // padding:
                                                  //     const EdgeInsets.all(
                                                  //         8),
                                                  // child: Text(
                                                  //   'For ${CardProductList[index].enumContractType}',
                                                  //   style: const TextStyle(
                                                  //       fontSize: 15,
                                                  //       color:
                                                  //           Colors.white),
                                                  // ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
