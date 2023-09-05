import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:betdelalamobile/helper/utility.dart';
import 'package:betdelalamobile/model/Products.dart';
import 'package:betdelalamobile/providers/products_user.dart';
import 'package:betdelalamobile/widget/post_pro.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:path/path.dart' as pa;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';

import '../helper/firebase_api.dart';
import '../providers/auth.dart';
import '../screens/google_map_screen.dart';
import '../theme/button_widget.dart';
import '../widget_functions/style.dart';

// ignore: must_be_immutable
class ProductsRegistration extends StatefulWidget {
  String? latitude = '11.5742', longitude = '37.3614';

  ProductsRegistration({required latitude, required longitude});

  @override
  State<ProductsRegistration> createState() => _ProductsRegistrationPageState();
}

class _ProductsRegistrationPageState extends State<ProductsRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController garageController = TextEditingController();
  TextEditingController BedsController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController poboxController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController profileNameController = TextEditingController();
  final _isInit = true;
  //Location currentLocation = Location();
  String? pid;
  String? _selectedCondition, _selectedPropertyType;
  double? userLocationLat, userLocationLon;
  UploadTask? task;
  Utility ut = Utility();
  File? file;
  bool startedTyping = false;
  Map<String, dynamic> urlData = {'houseImageentity': []};
  //     openHoursData = {'openHours': []};
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  String? imageUrl;
  final List<OpenHour> _businessHourss = [];
  List<HouseImageEntity> imageUrls = [];
  List<Address> address = [];
  List<String> propertyType = ["For Sale", 'For Rent'];
  List<String> propertyCondition = [
        "Apartment",
        "Villa",
        "Condominum",
        "Office",
        "Land",
      ],
      tags = [];
  var _editedProduct = Product(
    id: '',
    ProductName: '',
    City: '',
    StreetAdrress: '',
    Tags: '',
    description: '',
    lat: '',
    lng: '',
    selectedCondition: '',
    selectedPropertyType: '',
    beds: '',
    garage: '',
    houseImageEntites: [],
    price: '',
  );

  final _initValues = {
    'ProductName': '',
    'City': '',
    'StreetAdrress': '',
    'Tags': '',
    'description': '',
    'lat': '',
    'lng': '',
    'selectedCondition': '',
    'selectedPropertyType': '',
    'beds': '',
    'garage': '',
    'price': 0,
    'houseImageEntites': [],
  };

  // String _from = '7:00 AM', _to = '8:00 PM';

  LatLng? locationFromMap;
  double? locationFromMapLat, locationFromMapLon;
  String id = '';
  @override
  void didChangeDependencies() {
    // if (_isInit) {
    //   final productId = ModalRoute.of(context)!.settings.arguments as String;
    //   if (productId.isNotEmpty) {
    //     _editedProduct =
    //         Provider.of<Products>(context, listen: false).findById(productId);
    //     print(_editedProduct.StreetAdrress);
    //     _initValues = {
    //       'ProductName': _editedProduct.ProductName,
    //       'City': _editedProduct.City,
    //       'StreetAdrress': _editedProduct.StreetAdrress,
    //       'Tags': _editedProduct.Tags,
    //       'description': _editedProduct.description,
    //       'lat': _editedProduct.lat,
    //       'lng': _editedProduct.lng,
    //       'selectedCondition': '',
    //       'selectedPropertyType': '',
    //       'beds': _editedProduct.beds,
    //       'garage': _editedProduct.garage,
    //       'price': 12000,
    //       'houseImageEntites': imageUrls
    //     };
    //   }
    // }
    // _isInit = false;
    super.didChangeDependencies();
  }

  bool _isLoading = false;

  Future submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    // try {
    //   final response = await http.post(
    //     url,
    //     body: json.encode({

    //     }),
    //     headers: {
    //       'Content-Type': 'application/json',
    //     },
    //   );

    //   final responseData = json.decode(response.body);

    //   if (responseData['error'] != null) {
    //     throw HttpException(responseData['error']['message']);
    //   }
    //   if (response.statusCode == 200) {
    //     dialogue('success');

    //     //dialogue('We are not able to process your request at this time!');
    //   }
    // } catch (error) {
    //   print(error);
    // }
    Provider.of<Products>(context, listen: false)
        .addProduct(_editedProduct, context);
  }

  @override
  void initState() {
    super.initState();
    //getCurrentLocation();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   scrollController.dispose();
  // }

  onRefresh() {
    locationFromMapLat = null;
    locationFromMapLon = null;
    locationFromMapLat = locationFromMap!.latitude;
    locationFromMapLon = locationFromMap!.longitude;
    latitudeController.text = locationFromMapLat!.toStringAsFixed(5);
    longitudeController.text = locationFromMapLon!.toStringAsFixed(5);
    // scrollController.addListener(hideKeyboard);
    setState(() {});
  }

  // void getCurrentLocation() async {
  //   var location = await currentLocation.getLocation();
  //   userLocationLat = location.latitude!;
  //   userLocationLon = location.longitude!;
  // }

  photoPermission() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: TitleFont(
              text: 'Enable photo access!',
              size: ut.appFontSize('3t'),
            ),
            content: DescriptionFont(
              text:
                  'Please enable photo access so we can upload photos to customize your house product!',
              size: ut.appFontSize('4t'),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await Geolocator.openAppSettings();
                    //   .then(
                    //       (value) {
                    // if (value ==
                    //     true) {
                    //   onRefresh();
                    // }
                    // });
                  },
                  child: const TitleFont(text: 'Setting')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const TitleFont(text: 'Close'))
            ],
          );
        }));
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future selectFile() async {
    final result =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (result == null) return;
    final path = result.path;

    setState(() => file = File(path));
    uploadFile();
  }

  Future uploadFile() async {
    if (file == null) return;
    DateTime dateTime = DateTime.now();

    int currentMonth = dateTime.month;
    int currentYear = dateTime.year;

    final fileName = pa.basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {
      _isLoading = true;
    });

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final downloadURL = await snapshot.ref.getDownloadURL();

    setState(() {
      // urlDownload.add(_downloadURL);
      imageUrls.add(HouseImageEntity(url: downloadURL));
      _isLoading = false;
    });
  }

  void _removeImage(int index) {
    setState(() {
      imageUrls.removeAt(index);
    });
  }

  Widget _buildUploadStatus(UploadTask task) {
    return StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        // print(urlDownload);
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);
          return DescriptionFont(
            text: percentage == '100.00' || imageUrls.isNotEmpty
                ? '${imageUrls.length} Images added!'
                : 'Adding image: $percentage %',
            size: 18,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget imageindex(String url, int index) {
    return GestureDetector(
        child: Stack(children: [
      Container(
        // margin: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color:
            //     selectedFoodCard == index ? AppColors.primary : AppColors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.lightGreen,
                blurRadius: 15,
              )
            ]),
        child: Image.network(url, fit: BoxFit.contain),
      ),
      CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: () => {_removeImage(index)},
          icon: const Icon(Icons.delete_outline),
          color: Colors.red,
        ),
      )
    ]));
  }

  void dialogue(String message) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: 'Registration sucess!',
      desc: message,
      btnOkOnPress: () {
        // Navigator.of(context).pop();
      },
      btnOkIcon: Icons.check_circle,
      btnOkText: 'Ok',
      btnCancelOnPress: () {},
      btnCancelIcon: Icons.cancel,
      onDismissCallback: (type) {
        print('Dialog Dissmiss from callback $type');
      },
    ).show();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    //pid = Provider.of<Auth>(context, listen: false).pid;
    String? IdToken = Provider.of<Auth>(context).token;
    String userId = Provider.of<Products>(context).userId;
    final fileName =
        file != null ? pa.basename(file!.path) : 'No File Selected';
    return Scaffold(
      //   // backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      appBar: AppBar(
        title: const TitleFont(text: 'Register New Houses'),
        backgroundColor: const Color.fromARGB(255, 55, 92, 97),
        elevation: 0,
        leading: const BackButton(),
      ),
      //   // title: const Text('Register Restaurant'),
      //   // ,
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              // controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: TextFormField(
                      maxLength: 30,
                      textCapitalization: TextCapitalization.sentences,
                      controller: nameController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'Product   Name',
                      ),
                      onChanged: (val) {
                        startedTyping = true;
                      },
                      validator: (val) {
                        if (val.toString().isEmpty) {
                          return 'Product  name is required';
                        }

                        if (!(RegExp(r"^[a-zA-Z 1-9 ',]*$")
                            .hasMatch(val.toString()))) {
                          return 'Invalid Product';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            ProductName: value.toString(),
                            City: _editedProduct.City,
                            StreetAdrress: _editedProduct.StreetAdrress,
                            Tags: _editedProduct.Tags,
                            description: _editedProduct.description,
                            lat: _editedProduct.lat,
                            lng: _editedProduct.lng,
                            selectedCondition: _editedProduct.selectedCondition,
                            selectedPropertyType:
                                _editedProduct.selectedPropertyType,
                            beds: _editedProduct.beds,
                            garage: _editedProduct.garage,
                            price: _editedProduct.price,
                            houseImageEntites: imageUrls,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextFormField(
                      maxLength: 20,
                      textCapitalization: TextCapitalization.sentences,
                      controller: priceController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'Price',
                      ),
                      onChanged: (val) {
                        startedTyping = true;
                      },
                      validator: (val) {
                        if (val.toString().isEmpty) {
                          return 'Price is required';
                        }

                        if (!(RegExp(r"^[ 0-9 ]*$").hasMatch(val.toString()))) {
                          return 'Invalid Price';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            ProductName: _editedProduct.ProductName,
                            City: _editedProduct.City,
                            StreetAdrress: _editedProduct.StreetAdrress,
                            Tags: _editedProduct.Tags,
                            description: _editedProduct.description,
                            lat: _editedProduct.lat,
                            lng: _editedProduct.lng,
                            selectedCondition: _editedProduct.selectedCondition,
                            selectedPropertyType:
                                _editedProduct.selectedPropertyType,
                            beds: _editedProduct.beds,
                            garage: _editedProduct.garage,
                            price: value.toString(),
                            houseImageEntites: imageUrls,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextFormField(
                      maxLength: 20,
                      textCapitalization: TextCapitalization.sentences,
                      controller: cityController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'City',
                      ),
                      onChanged: (val) {
                        startedTyping = true;
                      },
                      validator: (val) {
                        if (val.toString().isEmpty) {
                          return 'City is required';
                        }

                        if (!(RegExp(r"^[a-zA-Z 0-9 ]*$")
                            .hasMatch(val.toString()))) {
                          return 'Invalid City';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            ProductName: _editedProduct.ProductName,
                            City: value.toString(),
                            StreetAdrress: _editedProduct.StreetAdrress,
                            Tags: _editedProduct.Tags,
                            description: _editedProduct.description,
                            lat: _editedProduct.lat,
                            lng: _editedProduct.lng,
                            selectedCondition: _editedProduct.selectedCondition,
                            selectedPropertyType:
                                _editedProduct.selectedPropertyType,
                            beds: _editedProduct.beds,
                            garage: _editedProduct.garage,
                            price: _editedProduct.price,
                            houseImageEntites: imageUrls,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      maxLength: 30,
                      textCapitalization: TextCapitalization.sentences,
                      controller: streetAddressController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'Street address',
                      ),
                      onChanged: (val) {
                        startedTyping = true;
                      },
                      validator: (val) {
                        if (val.toString().isEmpty) {
                          return 'Street address is required';
                        }

                        if (!(RegExp(r"^[a-zA-Z 0-9 ]*$")
                            .hasMatch(val.toString()))) {
                          return 'Invalid Address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            ProductName: _editedProduct.ProductName,
                            City: _editedProduct.City,
                            StreetAdrress: value.toString(),
                            Tags: _editedProduct.Tags,
                            description: _editedProduct.description,
                            lat: _editedProduct.lat,
                            lng: _editedProduct.lng,
                            selectedCondition: _editedProduct.selectedCondition,
                            selectedPropertyType:
                                _editedProduct.selectedPropertyType,
                            beds: _editedProduct.beds,
                            garage: _editedProduct.garage,
                            price: _editedProduct.price,
                            houseImageEntites: imageUrls,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                  ),
                  if (tags.length < 5)
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextFormField(
                        maxLength: 20,
                        textCapitalization: TextCapitalization.sentences,
                        // initialValue: widget.restaurantData.tag,
                        controller: tagsController,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Tags',
                        ),
                        onChanged: (val) {
                          startedTyping = true;
                        },
                        // validator: (val) {
                        //   if (tags.isEmpty && val!.isEmpty) {
                        //     return 'Tags is required';
                        //   }
                        //   if (tags.isEmpty && val!.isNotEmpty) {
                        //     return 'Please save your input on this field';
                        //   }

                        //   if (val.toString().characters.length > 20) {
                        //     return 'No more than 20 characters';
                        //   }
                        //   return null;
                        // },
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty &&
                              value != ' ' &&
                              value != '  ' &&
                              value != '   ' &&
                              value != '    ' &&
                              value != '     ') {
                            setState(() {
                              tags.add(value);
                              tagsController.clear();
                            });
                          }
                          return;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              ProductName: _editedProduct.ProductName,
                              City: _editedProduct.City,
                              StreetAdrress: _editedProduct.StreetAdrress,
                              Tags: value.toString(),
                              description: _editedProduct.description,
                              lat: _editedProduct.lat,
                              lng: _editedProduct.lng,
                              selectedCondition:
                                  _editedProduct.selectedCondition,
                              selectedPropertyType:
                                  _editedProduct.selectedPropertyType,
                              beds: _editedProduct.beds,
                              garage: _editedProduct.garage,
                              price: _editedProduct.price,
                              houseImageEntites: imageUrls,
                              isFavorite: _editedProduct.isFavorite);
                        },
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      maxLength: 250,
                      textCapitalization: TextCapitalization.sentences,
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'Product  Description',
                      ),
                      onChanged: (val) {
                        startedTyping = true;
                      },
                      validator: (val) {
                        if (val.toString().isEmpty) {
                          return 'house description is required';
                        }

                        if (val.toString().characters.length > 250) {
                          return 'No more than 250 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            ProductName: _editedProduct.ProductName,
                            City: _editedProduct.City,
                            StreetAdrress: _editedProduct.StreetAdrress,
                            Tags: _editedProduct.Tags,
                            description: value.toString(),
                            lat: _editedProduct.lat,
                            lng: _editedProduct.lng,
                            selectedCondition: _editedProduct.selectedCondition,
                            selectedPropertyType:
                                _editedProduct.selectedPropertyType,
                            beds: _editedProduct.beds,
                            houseImageEntites: imageUrls,
                            garage: _editedProduct.garage,
                            price: _editedProduct.price,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Location',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                maxLength: 10,
                                // initialValue:
                                //     locationFromMapLat!.toStringAsFixed(5),
                                controller: latitudeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  // suffixIcon: Icon(Icons.numbers),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  labelText: 'Latitude',
                                ),
                                onChanged: (val) {
                                  startedTyping = true;
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Latitude is required';
                                  }
                                  if (!RegExp(
                                          '^-?([1-8]?[1-9]|[1-9]0)\\.{1}\\d{1,6}')
                                      .hasMatch(value.toString())) {
                                    return 'invalid latitude';
                                  }
                                  // if (value.length > 9) {
                                  //   return 'Invalid phone number entered';
                                  // }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedProduct = Product(
                                      id: _editedProduct.id,
                                      ProductName: _editedProduct.ProductName,
                                      City: _editedProduct.City,
                                      StreetAdrress:
                                          _editedProduct.StreetAdrress,
                                      Tags: _editedProduct.Tags,
                                      description: _editedProduct.description,
                                      lat: value.toString(),
                                      lng: _editedProduct.lng,
                                      selectedCondition:
                                          _editedProduct.selectedCondition,
                                      selectedPropertyType:
                                          _editedProduct.selectedPropertyType,
                                      beds: _editedProduct.beds,
                                      houseImageEntites: imageUrls,
                                      garage: _editedProduct.garage,
                                      price: _editedProduct.price,
                                      isFavorite: _editedProduct.isFavorite);
                                  // }
                                },
                              ),
                            )),
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoogleMapScreen(
                                      // latitude:
                                      //     double.parse(widget.latitude!),
                                      // longitude:
                                      //     double.parse(widget.longitude!),
                                      // productname: nameController.text,
                                      // info: false,
                                      )),
                            );

                            locationFromMap = result;
                            onRefresh();
                          },
                          child: Column(
                            children: const [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color.fromRGBO(0, 142, 150, 1),
                                child: Icon(
                                  Icons.pin_drop,
                                  size: 40,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              TitleFont(
                                text: 'Pick on map',
                                size: 12,
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                maxLength: 10,
                                // initialValue:
                                //     locationFromMapLon!.toStringAsFixed(5),
                                controller: longitudeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  // suffixIcon: Icon(Icons.numbers),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  labelText: 'Longitude',
                                ),
                                onChanged: (val) {
                                  startedTyping = true;
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Longitude is required';
                                  }
                                  if (!RegExp(
                                          '^-?([1-8]?[1-9]|[1-9]0)\\.{1}\\d{1,6}')
                                      .hasMatch(value.toString())) {
                                    return 'invalid longitude';
                                  }
                                  // if (value.length > 9) {
                                  //   return 'Invalid phone number entered';
                                  // }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedProduct = Product(
                                    id: _editedProduct.id,
                                    ProductName: _editedProduct.ProductName,
                                    City: _editedProduct.City,
                                    StreetAdrress: _editedProduct.StreetAdrress,
                                    Tags: _editedProduct.Tags,
                                    description: _editedProduct.description,
                                    lat: _editedProduct.lat,
                                    lng: value.toString(),
                                    selectedCondition:
                                        _editedProduct.selectedCondition,
                                    houseImageEntites: imageUrls,
                                    selectedPropertyType:
                                        _editedProduct.selectedPropertyType,
                                    beds: _editedProduct.beds,
                                    garage: _editedProduct.garage,
                                    price: _editedProduct.price,
                                    isFavorite: _editedProduct.isFavorite,
                                  );
                                  // }
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                maxLength: 10,
                                // initialValue:
                                //     locationFromMapLat!.toStringAsFixed(5),
                                controller: garageController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  // suffixIcon: Icon(Icons.numbers),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  labelText: 'Garage',
                                ),
                                onChanged: (val) {
                                  startedTyping = true;
                                },
                                validator: (value) {
                                  if (!RegExp('^-?([1-8]?[1-9]|[1-9]0)')
                                      .hasMatch(value.toString())) {
                                    return 'invalid garage';
                                  }
                                  // if (value.length > 9) {
                                  //   return 'Invalid phone number entered';
                                  // }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedProduct = Product(
                                      id: _editedProduct.id,
                                      ProductName: _editedProduct.ProductName,
                                      City: _editedProduct.City,
                                      StreetAdrress:
                                          _editedProduct.StreetAdrress,
                                      Tags: _editedProduct.Tags,
                                      description: _editedProduct.description,
                                      lat: _editedProduct.lat,
                                      lng: _editedProduct.lng,
                                      houseImageEntites: imageUrls,
                                      selectedCondition:
                                          _editedProduct.selectedCondition,
                                      selectedPropertyType:
                                          _editedProduct.selectedPropertyType,
                                      beds: _editedProduct.beds,
                                      garage: value.toString(),
                                      price: _editedProduct.price,
                                      isFavorite: _editedProduct.isFavorite);
                                  // }
                                },
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                maxLength: 10,
                                // initialValue:
                                //     locationFromMapLon!.toStringAsFixed(5),
                                controller: BedsController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  // suffixIcon: Icon(Icons.numbers),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  labelText: 'Beds',
                                ),
                                onChanged: (val) {
                                  startedTyping = true;
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Beds is required';
                                  }
                                  if (!RegExp('^-?([1-8]?[1-9]|[1-9]0)')
                                      .hasMatch(value.toString())) {
                                    return 'invalid garage';
                                  }
                                  // if (value.length > 9) {
                                  //   return 'Invalid phone number entered';
                                  // }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedProduct = Product(
                                      id: _editedProduct.id,
                                      ProductName: _editedProduct.ProductName,
                                      City: _editedProduct.City,
                                      StreetAdrress:
                                          _editedProduct.StreetAdrress,
                                      Tags: _editedProduct.Tags,
                                      description: _editedProduct.description,
                                      lat: _editedProduct.lat,
                                      lng: _editedProduct.lng,
                                      selectedCondition: _selectedPropertyType,
                                      selectedPropertyType: _selectedCondition,
                                      beds: value.toString(),
                                      houseImageEntites: imageUrls,
                                      garage: _editedProduct.garage,
                                      price: _editedProduct.price,
                                      isFavorite: _editedProduct.isFavorite);
                                  // }
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child:
                          //  imageUrls.isNotEmpty
                          //     ?
                          Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            //imageUrls.isNotEmpty ? 190 : 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) => Padding(
                                        padding: EdgeInsets.only(
                                            left: index == 0 ? 25 : 0),
                                        child: imageindex(
                                            imageUrls[index].url, index)),
                                    itemCount: imageUrls.length,
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                if (imageUrls.length < 5)
                                  Expanded(
                                    flex: 5,
                                    child: GestureDetector(
                                      onTap: _isLoading
                                          ? null
                                          : () {
                                              selectFile();
                                              startedTyping = true;
                                            },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Center(
                                          child: _isLoading
                                              ? const MoreLoadingGif(
                                                  type:
                                                      MoreLoadingGifType.ripple)
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Icon(Icons.add),
                                                    DescriptionFont(
                                                        text: imageUrls.isEmpty
                                                            ? 'Add Images'
                                                            : 'Add More')
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          task != null
                              ? _buildUploadStatus(task!)
                              : Container(),
                        ],
                      )),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            hint: const Text('Select Product Condition'),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCondition = newValue!;
                              });
                            },
                            isExpanded: true,
                            items: propertyCondition
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please specify The products Condition';
                              }
                              return null;
                            },
                            value: _selectedCondition,
                          ),
                          // DropDown('Day *', _days, false, false, true)),
                          const SizedBox(height: 15),

                          DropdownButtonFormField<String>(
                            hint: const Text('Select Product Type'),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedPropertyType = newValue!;
                              });
                            },
                            isExpanded: true,
                            items: propertyType
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please specify The products Type';
                              }
                              return null;
                            },
                            value: _selectedPropertyType,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FractionallySizedBox(
                      widthFactor: 1,
                      child: ButtonWidget(
                          text: 'Register',
                          onClicked: () {
                            submit();
                          })),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
