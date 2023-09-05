// import 'package:betdelalamobile/helper/utility.dart';
// import 'package:betdelalamobile/providers/auth.dart';
// import 'package:betdelalamobile/widget/add_products.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_svg/svg.dart';

// import '../acounts/login.dart';
// import '../model/house_list_model.dart';
// import '../screens/detail_screen.dart';
// import '../theme/colors.dart';
// import '../widget/featured_product.dart';

// class PostedProducts extends StatefulWidget {
//   List<Content> PostedHouses;

//   PostedProducts({required this.PostedHouses});

//   @override
//   State<PostedProducts> createState() => _PostedProductsState();
// }

// class _PostedProductsState extends State<PostedProducts> {
//   String? pid, _selectedDay;
//   List<String> propertyType = ["Car ", 'House'];
//   final value = NumberFormat("#,##0.00", "en_US");
//   Utility ut = Utility();
//   @override
//   Widget build(BuildContext context) {
//     var deviceSize = MediaQuery.of(context).size;
//     return FutureBuilder<bool>(
//         future: Provider.of<Auth>(context).isAuth,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final isAuth = snapshot.data;
//             return Scaffold(
//               appBar: AppBar(
//                 systemOverlayStyle: const SystemUiOverlayStyle(
//                   statusBarColor: AppColors.secondary, // <-- SEE HERE
//                   statusBarIconBrightness:
//                       Brightness.dark, //<-- For Android SEE HERE (dark icons)
//                   statusBarBrightness:
//                       Brightness.light, //<-- For iOS SEE HERE (dark icons)
//                 ),
//                 backgroundColor: Colors.transparent,
//                 centerTitle: false,
//                 elevation: 0,
//                 leading: IconButton(
//                   tooltip: 'Register House',
//                   onPressed: () async {
                    
//                     if (isAuth == true) {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) => AddProduct(
//                                 latitude: '',
//                                 longitude: '',
//                               )));
//                     } else {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const LoginScreen()));
//                     }
//                   },
//                   icon: SvgPicture.asset(
//                     'assets/icons/add-plus-svgrepo-com.svg',
//                     width: 30,
//                   ),
//                 ),
//               ),
//               body: SingleChildScrollView(
//       //primary: true,

//       scrollDirection: Axis.vertical,
//       physics: const ScrollPhysics(),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//                     SizedBox(
//                       height: deviceSize.height * 0.5,
//                       width: deviceSize.width,
//                       child: const FeaturedProduct(),
//                     ),
//           Container(
//             height: deviceSize.height * 6.4,
//             padding: const EdgeInsets.fromLTRB(2, 15, 0, 0),
//             child: Card(
//               elevation: 20,
//               borderOnForeground: true,
//               shape: const RoundedRectangleBorder(
//                   side: BorderSide(width: 10, color: Colors.white)),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 10),
//                     width: double.infinity,
//                     child: const Text(
//                       'New posted Houses  ',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: widget.PostedHouses.length,
//                         //scrollDirection: Axis.vertical,
//                         itemBuilder: (context, index) {
//                           return widget.PostedHouses.isNotEmpty
//                               ? GestureDetector(
//                                   onTap: () {
//                                     Navigator.of(context)
//                                         .push(MaterialPageRoute(
//                                       builder: (_) => DetailScreen(
//                                                   productUid: widget
//                                                       .PostedHouses[index]
//                                                       .publicId,
//                                                   id: widget
//                                                       .PostedHouses[index].id,
//                                       ),
//                                     ));
//                                   },
//                                   child: Container(
//                                     width: deviceSize.width * 0.23,
//                                     height: deviceSize.height * 0.35,
//                                     decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                     ),
//                                     child: Container(
//                                                 padding:
//                                                     const EdgeInsets.fromLTRB(
//                                           10, 0, 10, 8),
//                                       child: Card(
//                                         semanticContainer: true,
//                                         elevation: 10,
//                                         borderOnForeground: true,
//                                         shape: const RoundedRectangleBorder(
//                                             side: BorderSide(
//                                                 style: BorderStyle.solid,
//                                                 width: 10,
//                                                 color: Colors.white)),
//                                         child: Column(
//                                           children: [
//                                             Container(
//                                                 alignment: Alignment.topRight,
//                                                 padding:
//                                                     const EdgeInsets.fromLTRB(
//                                                         0, 10, 10, 0),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     const Icon(
//                                                       Icons.location_on,
//                                                       size: 15,
//                                                     ),
//                                                     Text(
//                                                       '${widget.PostedHouses[index].addressLookups!.city}, ${widget.PostedHouses[index].addressLookups!.subCity}',
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       maxLines: 1,
//                                                       style: const TextStyle(
//                                                         color: Colors.indigo,
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.normal,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )),
//                                             Expanded(
//                                               child: Stack(
//                                                 children: [
//                                                   Card(
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                         image: DecorationImage(
//                                                             image: NetworkImage(widget
//                                                                 .PostedHouses[
//                                                                     index]
//                                                                 .propertyImagesList[
//                                                                     0]
//                                                                 .url),
//                                                             fit: BoxFit.cover),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Positioned(
//                                                     right: 11,
//                                                     top: 5,
//                                                     child: Container(
//                                                         alignment:
//                                                             Alignment.center,
//                                                         width:
//                                                             deviceSize.width *
//                                                                 0.2,
//                                                         height:
//                                                             deviceSize.height *
//                                                                 0.023,
//                                                         decoration:
//                                                             const BoxDecoration(
//                                                                 boxShadow: [
//                                                               BoxShadow(
//                                                                   color: Colors
//                                                                       .black54)
//                                                             ]),
//                                                         child: Text(
//                                                           'For ${widget.PostedHouses[index].enumContractType}',
//                                                           style:
//                                                               const TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   fontSize: 16,
//                                                                   color: Colors
//                                                                       .white),
//                                                         )),
//                                                   ),
//                                                   Positioned(
//                                                     //top: 0,
//                                                     bottom: 0,
//                                                     left: 0,
//                                                     right: 0,
//                                                     child: Container(
//                                                       padding: const EdgeInsets
//                                                               .fromLTRB(
//                                                           10, 10, 4, 10),
//                                                       color: Colors.white,
//                                                       child: Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: Text(
//                                                               '${value.format(widget.PostedHouses[index].price)} ${widget.PostedHouses[index].enumCurrencyType}',
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                               style: TextStyle(
//                                                                 color: Colors
//                                                                     .teal
//                                                                     .shade600,
//                                                                 fontSize: 16,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .normal,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Expanded(
//                                                             child: Text(
//                                                               '${widget.PostedHouses[index].bedrooms}bds, ${widget.PostedHouses[index].bathrooms}ba,${value.format(widget.PostedHouses[index].area)} sq m',
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                               maxLines: 1,
//                                                               style:
//                                                                   const TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 color: Color
//                                                                     .fromRGBO(
//                                                                         0,
//                                                                         0,
//                                                                         0,
//                                                                         0.541),
//                                                                 fontSize: 14,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : Container(
//                                   child: const Text('ZERO'),
//                                 );
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )
              
      
      
       