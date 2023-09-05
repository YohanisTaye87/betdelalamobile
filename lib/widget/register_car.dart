import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'drop_down.dart';
//import 'models_list_drop_down.dart';

class CarRegistrationForm extends StatefulWidget {
  final List<String>? conditionList;
  final List<String>? makeList;
  final List<String>? colorList;
  final List<String>? categoryList;
  final List<String>? carTypeList;
  final List<String>? transmissionTypeList;
  final List<String>? priceTypeList;
  final List<String>? sellerTypeList;
  final List<String>? fuelTypeList;
  final List<String>? engineTypeList;
  final List<String>? modelsList;
  final String email, phone, fullName;

  const CarRegistrationForm(
      {required this.makeList,
      required this.carTypeList,
      required this.categoryList,
      required this.colorList,
      required this.conditionList,
      required this.engineTypeList,
      required this.fuelTypeList,
      required this.priceTypeList,
      required this.sellerTypeList,
      required this.transmissionTypeList,
      required this.modelsList,
      required this.email,
      required this.fullName,
      required this.phone});
  @override
  _CarRegistrationFormState createState() => _CarRegistrationFormState();
}

String? _geoLocation;
void setGeoLocation(String geoLocation) {
  print(geoLocation);
  _geoLocation = geoLocation;
}

Map<String, dynamic> _newCar = {
  // "id": 0,
  "carCategory": "",
  "carType": "",
  "condition": "",
  "color": "",
  "doors": 0,
  "engineType": "",
  "fuelType": "",
  "geo_location": _geoLocation,
  "make": "",
  "mileage": 0,
  "model": "",
  "plate": "", //------------------------
  "price": 0,
  "priceType": "",
  "detail": "",
  "sellerName": "",
  "sellerPhone": "",
  "sellerEmail": "",
  "sellerType": "",
  "transmissionType": "",
  "vin": "",
  "year": 0,
};
void setCarCategory(String category) {
  _newCar['carCategory'] = category;
}

void setCarType(String carType) {
  _newCar['carType'] = carType;
}

void setCondition(String condition) {
  _newCar['condition'] = condition;
}

void setMake(String make) {
  _newCar['make'] = make;
}

void setYear(String year) {
  _newCar['year'] = int.parse(year);
}

void setModel(String model) {
  _newCar['model'] = model;
}

void setPriceType(String priceType) {
  _newCar['priceType'] = priceType;
}

void setFuelType(String fuelType) {
  _newCar['fuelType'] = fuelType;
}

void setEngineType(String engineType) {
  _newCar['engineType'] = engineType;
}

void setColor(String color) {
  _newCar['color'] = color;
}

void setTransmissionType(String transmissionType) {
  _newCar['transmissionType'] = transmissionType;
}

void setSellerType(String sellerType) {
  _newCar['sellerType'] = sellerType;
}

void setDoors(String doors) {
  _newCar['doors'] = doors == '  2 - Doors'
      ? 2
      : (doors == '  4 - Doors')
          ? 4
          : 4; //default 4
}

void setCategory(String category) {
  _newCar['category'] = category;
}

void setOfferType(String offerType) {
  _newCar['offer_type'] = offerType;
}

List<String> years = [];
void _setYears() {
  years = [];
  for (int i = DateTime.now().year; i > DateTime.now().year - 50; i--) {
    years.add(i.toString());
  }
}

class _CarRegistrationFormState extends State<CarRegistrationForm> {
  //String _name = "", _email = "", _phone = "", _message = "";
  bool _isChecked = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  static final List<String> _driveTypeList = [
    '  AWD / 4WD',
    '  Front Wheel Drive',
    '  Rear Wheel Drive'
  ];
  // static List<String> _cylinderList = ['  4', '  6', '  8'];
  static final List<String> _doorList = [
    '  2 - Doors',
    '  4 - Doors',
  ];

  Widget _buildSellerNameTextField() {
    return TextFormField(
      // initialValue:
      //     "${Provider.of<Auth>(context).userData['firstName']} ${Provider.of<Auth>(context).userData['lastName']}",
      decoration: const InputDecoration(
          labelText: 'Seller\'s Name', border: OutlineInputBorder()),
      keyboardType: TextInputType.name,
      validator: (val) {
        if (val.toString().isEmpty) return 'Name is Required';
        if (!(RegExp(r"^[a-zA-Z ]*$").hasMatch(val.toString()))) {
          return 'Invalid Name';
        }
        return null;
      },
      onSaved: (val) {
        _newCar['sellerName'] = val.toString();
      },
    );
  }

  Widget _buildTextField(String text) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: text, border: const OutlineInputBorder()),
      keyboardType: TextInputType.name,
      validator: (val) {
        if (val.toString().isEmpty) return '$text is Required';
        return null;
      },
      onSaved: (val) {
        switch (text) {
          case 'Plate Start':
            _newCar['plate'] = val.toString();
            break;
          case 'VIN':
            _newCar['vin'] = val.toString();
            break;
          default:
            return;
        }
      },
    );
  }

  Widget _buildSellerEmailTextField() {
    return TextFormField(
      // initialValue: "${Provider.of<Auth>(context).userData['userName']}",
      decoration: const InputDecoration(
          labelText: 'Email *', border: OutlineInputBorder()),
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        if (val.toString().isEmpty) return 'Seller\'s email is required';
        if (!(RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val.toString()))) return 'Invalid email address';
        return null;
      },
      onSaved: (val) {
        _newCar["sellerEmail"] = val.toString();
      },
    );
  }

  Widget _buildNumericalTextField(String text) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: text, border: const OutlineInputBorder()),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val.toString().isEmpty) return '$text is required';
        if (!RegExp(r"^[0-9]").hasMatch(val.toString())) return 'invalid entry';
        return null;
      },
      onSaved: (val) {
        print(val);
        switch (text) {
          case 'Year *':
            _newCar['year'] = int.parse(val.toString());
            break;
          case 'Price *':
            _newCar['price'] = double.parse(val.toString());
            break;
          case 'Mile Age':
            _newCar['mileage'] = int.parse(val.toString());
            break;
          default:
            return;
        }
      },
    );
  }

  Widget _buildDescriptionTextArea() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Description *', border: OutlineInputBorder()),
      keyboardType: TextInputType.multiline,
      minLines: 7,
      maxLines: 10,
      validator: (val) {
        if (val.toString().isEmpty) return 'Description is required';
        return null;
        //add more validations..minimum length and maximum length
      },
      onSaved: (val) {
        _newCar['detail'] = val.toString();
      },
    );
  }

  Widget _buildSellerPhoneTextField() {
    return TextFormField(
      // initialValue: "${Provider.of<Auth>(context).userData['phone']}",
      decoration: const InputDecoration(
          labelText: 'Seller Phone *', border: OutlineInputBorder()),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val.toString().isEmpty) return 'Seller\'s Phone number is required';
        if (!RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(val.toString())) {
          return 'invalid phone number';
        }
        return null; //find another consistent way
      },
      onSaved: (val) {
        _newCar['sellerPhone'] = val.toString();
      },
    );
  }

  Future<void> _saveNewCar() async {
    final url =
        Uri.parse('https://cqfntvunda.us-east-1.awsapprunner.com/car/register');

    try {
      // print('position 0');
      final jsonBody = json.encode(
        {
          "condition": _newCar['condition'].toString(),
          "carCategory": _newCar['carCategory'].toString(),
          "carType": _newCar['carType'].toString(),
          "model": _newCar['model'].toString(),
          "price": _newCar['price'] as double,
          "year": _newCar['year'] as int,
          "plate": _newCar['plate'].toString(),
          "priceType": _newCar['priceType'].toString(),
          "mileage": _newCar['mileage'].toString(),
          "doors": _newCar['doors'].toString(),
          "vin": _newCar['vin'].toString(),
          "engineType": _newCar['engineType'].toString(),
          "fuelType": _newCar['fuelType'].toString(),
          "transmissionType": _newCar['transmissionType'].toString(),
          "detail": _newCar['detail'].toString(),
          "sellerName": _newCar['sellerName'].toString(),
          "sellerPhone": _newCar['sellerPhone'].toString(),
          "sellerEmail": _newCar['sellerEmail'].toString(),
          "sellerType": _newCar['sellerType'].toString(),
          "make": _newCar['make'].toString(),
          "color": _newCar['color'].toString(),
          "geo_location": _geoLocation
        },
      );
      // print('position 1');
      final response = await http.post(
        url,
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization':
          //     ' Bearer ${Provider.of<Auth>(context, listen: false).token}',
          // 'pid': '${Provider.of<Auth>(context, listen: false).userId}'
        },
      );

      // print('position 2');
      final responseData = json.decode(response.body);
      print(response.body);
      if (responseData['error'] != null) {
        //later use status code
        throw 'error'; // HttpException(responseData['error']['message']);
      }
      //setCarPublicId(responseData['carPublicId']);

      // Navigator.of(context).pushNamed(UploadCarImageScreen.routeName);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.done, size: 18, color: Colors.green),
            SizedBox(width: 20),
            Text('Car Info Saved. Please Upload Images.',
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
      ));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _showConfirmationDialogue() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('LOGIN REQUIRED.'),
            content: const Text('You need to login before posting a car.'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context)
                    //     .pushNamed(AuthScreen.routeName)
                    //     .then((_) {
                    //   Navigator.of(context).pop();
                  },
                  // Navigator.of(context).pop();

                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text('Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue)),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text('cancel', style: TextStyle(color: Colors.red)),
                  )),
            ],
          );
        });
  }

  // void _nextButtonHandler() async {
  //   if (Provider.of<Auth>(context, listen: false).isAuth) {
  //     if (!_formkey.currentState!.validate() || !_isChecked) return;
  //     _formkey.currentState!.save();

  //     print("Form Saved!");
  //     await _saveNewCar();
  //     // Navigator.of(context).pop();
  //   } else {
  //     await _showConfirmationDialogue();
  //     if (Provider.of<Auth>(context, listen: false).isAuth) {
  //       if (!_formkey.currentState!.validate() || !_isChecked) return;
  //       _formkey.currentState!.save();
  //       //print(_newCar);
  //       await _saveNewCar();
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: const [
  //             Icon(Icons.cancel, size: 18, color: Colors.redAccent),
  //             SizedBox(width: 20),
  //             Text('You are not Logged In. Please Login first.',
  //                 style: TextStyle(
  //                     color: Colors.redAccent, fontWeight: FontWeight.bold)),
  //           ],
  //         ),
  //       ));
  //     }
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose

    if (_formkey.currentState != null) _formkey.currentState!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _setYears();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            //border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 6,
                  ),
                  //height: 5,
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Car Information',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                // _buildTextField('Display Name *'),
                // SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown('Car Condition *', widget.conditionList,
                        true, false, false)),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown(
                        'Color', widget.colorList, true, false, false)),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown(
                        'Category *', widget.categoryList, true, false, false)),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown(
                        'Type *', widget.carTypeList, true, false, false)),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child:
                        DropDown('Make *', widget.makeList, true, true, false)),
                const SizedBox(height: 20),
                // Container(
                //     decoration:
                //         BoxDecoration(border: Border.all(color: Colors.grey)),
                //     child: ModelsListDropDown('Model *', widget.modelsList)),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown('Year *', years, true, false, false)),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown('Transmission *',
                        widget.transmissionTypeList, true, false, false)),
                const SizedBox(height: 20),
                _buildNumericalTextField('Price *'),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown('Price Type *', widget.priceTypeList, true,
                        false, false)),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown(
                        'Fuel Type', widget.fuelTypeList, true, false, false)),
                const SizedBox(height: 20),
                _buildNumericalTextField('Mile Age'),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown(
                        'Drive Type', _driveTypeList, true, false, false)),
                const SizedBox(height: 20),
                // _buildNumericalTextField('Engine Size'),
                // SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown('Engine Type', widget.engineTypeList, true,
                        false, false)),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown('Doors *', _doorList, true, false, false)),
                const SizedBox(height: 20),
                _buildTextField('VIN'),
                const SizedBox(height: 20),
                _buildTextField('Plate Start'),
                const SizedBox(height: 20),
                _buildDescriptionTextArea(),
                const SizedBox(height: 20),
                //display map to enter location
                Container(
                  margin: const EdgeInsets.only(
                    top: 6,
                  ),
                  //height: 5,
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                // MapWidget(),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(
                    top: 6,
                  ),
                  //height: 5,
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Seller\'s Information',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                _buildSellerNameTextField(),
                const SizedBox(height: 20),
                _buildSellerPhoneTextField(),
                const SizedBox(height: 20),
                _buildSellerEmailTextField(),
                const SizedBox(height: 20),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropDown('Seller Type *', widget.sellerTypeList,
                        true, false, false)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.blue[700],
                        value: _isChecked,
                        onChanged: (ischecked) {
                          setState(() {
                            _isChecked = ischecked as bool;
                          });
                        }),
                    const Text('I accept the '),
                    TextButton(
                      onPressed: () {
                        /* should send to privacy terms page */
                      },
                      child: const Text('privacy policy'),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: 220,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () => () {}, //_nextButtonHandler(),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Next',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.navigate_next, size: 22),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // MainFooter(),
      ],
    );
  }
}
