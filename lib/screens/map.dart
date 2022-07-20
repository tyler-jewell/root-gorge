// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:root_gorge/api/firestore_api.dart';
// import 'package:root_gorge/models/field.dart';
// import 'package:root_gorge/repositories/crops.dart';
// import 'package:root_gorge/repositories/herbicides.dart';

// class Map extends StatefulWidget {
//   const Map({Key? key}) : super(key: key);

//   @override
//   State<Map> createState() => _MapState();
// }

// class _MapState extends State<Map> {
//   List<Marker> markers = <Marker>[];
//   bool showAddFieldBottomSheet = false;
//   bool showEditFieldBottomSheet = false;
//   Field? selectedField;

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(40.01755830492381, -89.04235593358224),
//     zoom: 14.4746,
//   );

//   @override
//   Widget build(BuildContext context) {
//     _getMarkers();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Field Marker'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: 'Logout',
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//             },
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: showAddFieldBottomSheet || showEditFieldBottomSheet
//           ? null
//           : FloatingActionButton(
//               child: const Icon(Icons.add),
//               onPressed: () {
//                 setState(() {
//                   showAddFieldBottomSheet = true;
//                 });
//               },
//             ),
//       bottomSheet: showAddFieldBottomSheet
//           ? Container(
//               height: 100,
//               width: double.infinity,
//               color: Colors.white,
//               child: Center(
//                 child: Text(
//                   'Tap location of field to add',
//                   style: Theme.of(context).textTheme.headline5,
//                 ),
//               ),
//             )
//           : showEditFieldBottomSheet
//               ? Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20)),
//                   ),
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Field Details',
//                         style: Theme.of(context).textTheme.headline5,
//                       ),
//                       const SizedBox(height: 5),
//                       Text('Crop type: ${selectedField?.crop}'),
//                       const SizedBox(height: 5),
//                       Text('Herbicide type: ${selectedField?.herbicide}'),
//                       const SizedBox(height: 5),
//                       Text('Phone number: ${selectedField?.phoneNumber}'),
//                       const SizedBox(height: 5),
//                       Text('Name: ${selectedField?.name}'),
//                     ],
//                   ),
//                 )
//               : null,
//       body: Stack(
//         children: [
//           GoogleMap(
//             mapType: MapType.satellite,
//             initialCameraPosition: _kGooglePlex,
//             onTap: showAddFieldBottomSheet
//                 ? (latLng) {
//                     _addMarker(latLng);
//                     setState(() {
//                       showAddFieldBottomSheet = false;
//                     });
//                   }
//                 : (latLng) {
//                     setState(() {
//                       showEditFieldBottomSheet = false;
//                     });
//                   },
//             markers: Set<Marker>.of(markers),
//           ),
//         ],
//       ),
//     );
//   }

//   _getMarkers() async {
//     final fields = await FirestoreFieldsApi().getFields();

//     List<Marker> fieldMarkers = [];

//     for (var field in fields) {
//       final marker = await _buildMarkerFromField(field);
//       fieldMarkers.add(marker);
//     }

//     setState(() {
//       markers = fieldMarkers;
//     });
//   }

//   Future<Marker> _buildMarkerFromField(Field field) async {
//     return Marker(
//         markerId: MarkerId(field.latitude.toString()),
//         position: LatLng(field.latitude, field.longitude),
//         icon: await _getBitmap(
//           cropType: field.crop,
//           herbicideType: field.herbicide,
//         ),
//         onTap: () {
//           setState(() {
//             showEditFieldBottomSheet = true;
//             selectedField = field;
//           });
//         });
//   }

//   _getBitmap({
//     required String cropType,
//     required String herbicideType,
//   }) async {
//     late String file;
//     if (cropType == 'Corn') {
//       if (herbicideType == 'Dicamba') {
//         file = "assets/markers/corn-dicamba.png";
//       } else if (herbicideType == 'Enlist') {
//         file = "assets/markers/corn-enlist.png";
//       } else if (herbicideType == 'Roundup') {
//         file = "assets/markers/corn-roundup.png";
//       } else if (herbicideType == 'Non-GMO') {
//         file = "assets/markers/corn-non-gmo.png";
//       } else if (herbicideType == 'Organic') {
//         file = "assets/markers/corn-organic.png";
//       }
//     } else if (cropType == 'Soybean') {
//       if (herbicideType == 'Dicamba') {
//         file = "assets/markers/soybean-dicamba.png";
//       } else if (herbicideType == 'Enlist') {
//         file = "assets/markers/soybean-enlist.png";
//       } else if (herbicideType == 'Roundup') {
//         file = "assets/markers/soybean-roundup.png";
//       } else if (herbicideType == 'Non-GMO') {
//         file = "assets/markers/soybean-non-gmo.png";
//       } else if (herbicideType == 'Organic') {
//         file = "assets/markers/soybean-organic.png";
//       }
//     } else if (cropType == 'Wheat') {
//       if (herbicideType == 'Dicamba') {
//         file = "assets/markers/wheat-dicamba.png";
//       } else if (herbicideType == 'Enlist') {
//         file = "assets/markers/wheat-enlist.png";
//       } else if (herbicideType == 'Roundup') {
//         file = "assets/markers/wheat-roundup.png";
//       } else if (herbicideType == 'Non-GMO') {
//         file = "assets/markers/wheat-non-gmo.png";
//       } else if (herbicideType == 'Organic') {
//         file = "assets/markers/wheat-organic.png";
//       }
//     }

//     return await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(58, 58)),
//       file,
//     );
//   }

//   _addMarker(LatLng latLng) async {
//     final cropType = await showDialog<String>(
//         context: context,
//         builder: (BuildContext context) {
//           return SimpleDialog(
//             title: const Text('Select type of field'),
//             children: getCropTypes()
//                 .map(
//                   (cropType) => SimpleDialogOption(
//                     child: Text(cropType.name),
//                     onPressed: () => Navigator.pop(context, cropType.name),
//                   ),
//                 )
//                 .toList(),
//           );
//         });

//     final herbicideType = await showDialog<String>(
//         context: context,
//         builder: (BuildContext context) {
//           return SimpleDialog(
//             title: const Text('Select type of herbicide'),
//             children: getHerbicides()
//                 .map(
//                   (herbicide) => SimpleDialogOption(
//                     child: Text(herbicide.name),
//                     onPressed: () => Navigator.pop(context, herbicide.name),
//                   ),
//                 )
//                 .toList(),
//           );
//         });

//     final phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
//     final name = FirebaseAuth.instance.currentUser?.displayName;

//     final field = Field(
//       userId: FirebaseAuth.instance.currentUser!.uid,
//       latitude: latLng.latitude,
//       longitude: latLng.longitude,
//       crop: cropType!,
//       herbicide: herbicideType!,
//       phoneNumber: phoneNumber,
//       name: name,
//     );

//     FirebaseFirestore.instance.collection('fields').add(field.toJson());

//     final marker = await _buildMarkerFromField(field);

//     setState(() {
//       markers.add(marker);
//     });
//   }
// }
