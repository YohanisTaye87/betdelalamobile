// ignore_for_file: deprecated_member_use, prefer_const_constructors, constant_identifier_names

import 'package:betdelalamobile/model/house_list_model.dart';
import 'package:betdelalamobile/screens/detail_screen.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/house_product_list.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/mapscreen';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final Set<Marker> _markers = {};
  static const _initalCameraPosition =
      CameraPosition(target: LatLng(9.005401, 38.763611), zoom: 12);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<HouseProductList>(context, listen: false)
        .resetSearchResultPage();
    super.dispose();
  }

  final value = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final searchResultItem =
        Provider.of<HouseProductList>(context, listen: false).searchResult;
    late GoogleMapController mapController;
    for (int i = 0; i < searchResultItem.length; i += 1) {
      if (searchResultItem[i].latitude.isEmpty ||
          searchResultItem[i].longitude.isEmpty) {
        _markers.add(Marker(
          markerId: MarkerId(searchResultItem[i].publicId),
          position: LatLng(9.035018, 38.750877),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            markerProduct(searchResultItem, i, LatLng(9.035018, 38.750877));
          },
        ));
      } else {
        _markers.add(Marker(
          markerId: MarkerId('${searchResultItem[i].id}'),
          position: LatLng(double.parse(searchResultItem[i].latitude),
              double.parse(searchResultItem[i].longitude)),
          infoWindow: InfoWindow(
              //title: _searchResultItem[i].addressLookups!.subCity,

              ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            markerProduct(
                searchResultItem,
                i,
                LatLng(double.parse(searchResultItem[i].latitude),
                    double.parse(searchResultItem[i].longitude)));
          },
        ));
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Container(
              margin: EdgeInsets.all(8),
              child: ElevatedButton.icon(
                icon: Icon(Icons.search_rounded),
                label: const Text(
                  'Component search',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  //primary: Colors.teal.shade600,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        body: searchResultItem.isNotEmpty
            ? Stack(children: [
                GoogleMap(
                  markers: _markers,
                  initialCameraPosition: _initalCameraPosition,
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _customInfoWindowController.googleMapController =
                        controller;
                  },
                  onCameraMove: (position) {
                    _customInfoWindowController.onCameraMove!();
                  },
                  // onTap: (postion) {
                  //   _customInfoWindowController.hideInfoWindow!();
                  // },
                ),
                Positioned(
                    bottom: 15,
                    right: 0,
                    left: 0,
                    top: 0,
                    child: CustomInfoWindow(
                      controller: _customInfoWindowController,
                      height: 100,
                      width: 150,
                      offset: 35,
                    ))
              ])
            : const Text(''));
  }

  buildContainer(List<Content> searchResultItem, int index) {
    return Container(child: Text(searchResultItem[index].title));
  }

  markerProduct(List<Content> searchResultItem, int i, LatLng latLng) {
    _customInfoWindowController.addInfoWindow!(
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DetailScreen(
                productUid: searchResultItem[i].publicId,
                id: searchResultItem[i].id,
              ),
            ));
          },
          child: Container(
            height: 300,
            width: 200,
            decoration: BoxDecoration(
              //border: const Border(bottom: BorderSide(width: 10)),
              image: DecorationImage(
                  image: NetworkImage(
                      searchResultItem[i].propertyImagesList[0].url),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        latLng);
  }
}
