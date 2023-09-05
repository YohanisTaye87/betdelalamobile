import 'package:flutter/material.dart';

class DetailForm extends StatefulWidget {
  String value;
  var dataValue;
  DetailForm({required this.dataValue, required this.value});

  @override
  State<DetailForm> createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        color: Colors.grey.shade100,
        //borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              //alignment:Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 2),
              margin: const EdgeInsets.fromLTRB(20, 10, 0, 3),
              child: Text(
                '${widget.value} : ',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              margin: const EdgeInsets.fromLTRB(0, 10, 20, 3),
              alignment: Alignment.topRight,
              child: Text(
                ' ${widget.dataValue}',
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
