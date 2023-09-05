import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/house_list_model.dart';
import '../screens/detail_screen.dart';

class SearchResult extends StatefulWidget {
  List<Content> searchProducts;

  SearchResult({required this.searchProducts});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final value = NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    print(widget.searchProducts.length);
    return Container(
      width: deviceSize.width,
      height: deviceSize.height,
      padding: const EdgeInsets.fromLTRB(2, 15, 0, 5),
      child: Card(
        elevation: 20,
        borderOnForeground: true,
        shape: const RoundedRectangleBorder(
            side: BorderSide(width: 10, color: Colors.white)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              child: const Text(
                'Search Results  ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.searchProducts.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return widget.searchProducts.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => DetailScreen(
                                  productUid:
                                      widget.searchProducts[index].publicId,
                                  id: widget.searchProducts[index].id,
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 8),
                                child: Card(
                                  semanticContainer: true,
                                  elevation: 10,
                                  borderOnForeground: true,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 10,
                                          color: Colors.white)),
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.topRight,
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 10, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                size: 15,
                                              ),
                                              Text(
                                                '${widget.searchProducts[index].addressLookups!.city}, ${widget.searchProducts[index].addressLookups!.subCity}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Card(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(widget
                                                          .searchProducts[index]
                                                          .propertyImagesList[0]
                                                          .url),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 12,
                                              top: 5,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width:
                                                      deviceSize.width * 0.2,
                                                  height:
                                                      deviceSize.height * 0.025,
                                                  decoration:
                                                      const BoxDecoration(
                                                          boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black54)
                                                      ]),
                                                  child: Text(
                                                    'For ${widget.searchProducts[index].enumContractType}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 4, 10),
                                                color: Colors.white,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${value.format(widget.searchProducts[index].price)} ${widget.searchProducts[index].enumCurrencyType}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .teal.shade600,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${widget.searchProducts[index].bedrooms}bds, ${widget.searchProducts[index].bathrooms}ba,${value.format(widget.searchProducts[index].area)} sq m',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.541),
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
                          )
                        : Container(
                            child: const Text('',style: TextStyle(fontSize: 30),),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
