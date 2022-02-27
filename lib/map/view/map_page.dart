import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatelessWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _polygons = <Polygon>{
//       const Polygon(
//         polygonId: PolygonId('polygon_1'),
//         points: <LatLng>[
//           LatLng(37.42796133580664, -122.085749655962),
//           LatLng(37.43015439453125, -122.0849952697754),
//           LatLng(37.43095397949219, -122.085749655962),
//           LatLng(37.43116760253906, -122.08642578125),
//           LatLng(37.43152618408203, -122.0867309570312),
//           LatLng(37.43152618408203, -122.0870208740234),
//           LatLng(37.431373596191406, -122.0870208740234),
//           LatLng(37.431373596191406, -122.08642578125),
//           LatLng(37.43152618408203, -122.08642578125),
//           LatLng(37.43152618408203, -122.085749655962),
//           LatLng(37.42796133580664, -122.085749655962),
//         ],
//         fillColor: Colors.green,
//         strokeColor: Colors.green,
//         strokeWidth: 1,
//       ),
//     };

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: GoogleMap(
//           initialCameraPosition: const CameraPosition(
//             target: LatLng(37.42796133580664, -122.085749655962),
//             zoom: 14,
//           ),
//           onTap: (latLng) {
//             log(latLng.toString());
//             // context.read<MapBloc>().add(MarkerAddedToPlot('poly-a', latLng));
//           },
//           polygons: _polygons,
//         ),
//       ),
//     );
//   }
// }

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
