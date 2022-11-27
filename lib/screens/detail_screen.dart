import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/houses.dart';

class DetailScreen extends StatelessWidget {
  static final routename = 'routes';
  const DetailScreen({super.key});
  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSectionTitle(BuildContext context, String text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );
    }

    final abc = ModalRoute.of(context)!.settings().arguments;
    final userElement =
        Provider.of<Houses>(context, listen: false).findById(abc as dynamic);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
            )
          ]),
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  userElement.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle(context, 'specification'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 5,
                        ),
                        child: Text(
                          '${userElement.specification[index]}',
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                  ),
                  itemCount: userElement.specification.length,
                ),
              ),
              buildSectionTitle(context, 'description'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(
                        title: Text(
                          userElement.description[index],
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                      ),
                    ],
                  ),
                  itemCount: userElement.description.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
