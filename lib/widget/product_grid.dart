import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/houses.dart';
import '../screens/detail_screen.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendedList = Provider.of<Houses>(context).items;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.grey.shade100
            // blurRadius: 15.0, // soften the shadow
            //spreadRadius: 5.0, //extend the shadow

            )
      ]),
      margin: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: recommendedList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              DetailScreen.routename,
              arguments: recommendedList[index].id,
            );
          },
          child: Container(
            width: 230,
            height: 300,
            margin: const EdgeInsets.only(bottom: 20),
            //padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: const Border(bottom: BorderSide(width: 10)),
                    image: DecorationImage(
                        image: NetworkImage(
                          recommendedList[index].imageUrl,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 15,
                  child: Container(
                      width: 90,
                      height: 30,
                      // padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.blue.shade50)]),
                      child: const Text(
                        'For sale',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      )),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    //margin: EdgeInsets.only(bottom: 50),
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recommendedList[index].price,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                recommendedList[index].information,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 0.541),
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              recommendedList[index].location,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              recommendedList[index].rentInformation,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        // child: SvgPicture.asset('assets/icons/heart.svg'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
