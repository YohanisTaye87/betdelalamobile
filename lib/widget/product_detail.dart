import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/houses.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});
  Widget buildContainer(Widget child) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSectionTitle(BuildContext context, String text) {
      return Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }

    final abc = ModalRoute.of(context)!.settings().arguments;
    final userElement =
        Provider.of<Houses>(context, listen: false).findById(abc as dynamic);
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.fromLTRB(10, 25, 10, 25),
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        boxShadow: [
          BoxShadow(
              offset: Offset.zero,
              spreadRadius: 6,
              blurRadius: 6.0,
              blurStyle: BlurStyle.solid,
              color: Colors.white)
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: 25,
                //width: 80,
                //color: Colors.blueAccent,
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(left: 250, top: 20),
                child: Text(
                  'Contact Agent',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 19,
                      color: Colors.blue),
                )),
            Stack(children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  userElement.imageUrl,
                  fit: BoxFit.cover,
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
            ]),
            //buildSectionTitle(context, 'specification'),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          userElement.price,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Text(userElement.information,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal))),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    userElement.location,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Specification:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                buildContainer(ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  itemCount: userElement.specification.length,
                  itemBuilder: ((context, index) => Text(
                        userElement.specification[index],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      )),
                )),
                SizedBox(
                  height: 10,
                ),
                buildSectionTitle(context, 'Specification:'),
                Container(
                  child: Text(
                    userElement.description[0],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
