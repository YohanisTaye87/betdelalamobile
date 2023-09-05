import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search_form.dart';

class DropDown extends StatefulWidget {
  final String text;
  final bool isCarReg, isDropDownMake, isDealerReg;
  final List<String>? itemsList;
  DropDown(this.text, this.itemsList, this.isCarReg, this.isDropDownMake,
      this.isDealerReg);
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  void selectionHandlerForNonMakeDrops(String value) {
    setState(() {
      _isSelected = true;
      _selectedDrop = value;
    });
  }

  DropdownMenuItem<String> _buildDropDownMenuItem(String valueItem) {
    return DropdownMenuItem<String>(
      value: valueItem,
      child: Text(valueItem),
    );
  }

  void carSearchDrops(String value) {
    selectionHandlerForNonMakeDrops(value);
    switch (widget.text) {
      case 'Category':
        setcategoryOptions(value);
        break;
      case 'Location':
        setLocationOption(value);
        break;
      case 'Condition':
        setcontractTypeOption(value);
        break;
      case 'Type':
        setconditionOptions(value);
        break;
      case 'Min Year':
        setminYear(value);
        break;
      case 'Max Year':
        setmaxYear(value);
        break;
      default:
        return;
    }
  }

  void onChangeHandler(String? value) {
    {
      if (widget.isCarReg) {
        widget.isDropDownMake ? (value.toString()) : value.toString();
      } else {
        if (widget.isDealerReg) {
          // dealerRegSelection(value.toString());
        } else {
          print('in else b4 search');
          carSearchDrops(value.toString());
        }
        // selectionHandlerForNonMakeDrops(value.toString());
      }
    }
    // selectionHandlerForNonMakeDrops(value.toString());
  }

  bool _isSelected = false;
  String _selectedDrop = "";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
        value: _isSelected ? _selectedDrop : null,
        underline: const SizedBox(),
        hint: !_isSelected
            ? Text("  " + widget.text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            : null,
        icon: Expanded(
          // ignore: prefer_const_literals_to_create_immutables
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(color: Colors.white38),
              child: const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
                size: 50,
              ),
            ),
          ]),
        ),
        iconSize: 18,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        onChanged: (value) => onChangeHandler(value),
        items: widget.itemsList == null
            ? null
            : widget.itemsList!.map(_buildDropDownMenuItem).toList());
  }
}
