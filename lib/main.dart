import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/firebase_options.dart';

class CropType {
  CropType(this.name);

  final String name;
}

class HerbicideType {
  HerbicideType(
    this.name,
    this.color,
  );
  final String name;
  final Color color;
}

final herbicides = [
  HerbicideType('Dicamba', Colors.blue),
  HerbicideType('Enlist', Colors.orange),
  HerbicideType('Roundup', Colors.green),
  HerbicideType('Non-GMO', Colors.yellow),
  HerbicideType('Organic', Colors.red),
];

final cropTypes = [
  CropType('Corn'),
  CropType('Wheat'),
  CropType('Soybean'),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        isSignedIn = user != null;
      });
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isSignedIn ? const Map() : const Login(),
    );
  }
}

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  List<Marker> markers = <Marker>[];
  String appBarTitle = 'No Press';
  bool isAdding = false;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.01755830492381, -89.04235593358224),
    zoom: 14.4746,
  );

  _getBitmap({
    required String cropType,
    required String herbicideType,
  }) async {
    late String file;
    if (cropType == 'Corn') {
      if (herbicideType == 'Dicamba') {
        file = "assets/markers/corn-dicamba.png";
      } else if (herbicideType == 'Enlist') {
        file = "assets/markers/corn-enlist.png";
      } else if (herbicideType == 'Roundup') {
        file = "assets/markers/corn-roundup.png";
      } else if (herbicideType == 'Non-GMO') {
        file = "assets/markers/corn-non-gmo.png";
      } else if (herbicideType == 'Organic') {
        file = "assets/markers/corn-organic.png";
      }
    } else if (cropType == 'Soybean') {
      if (herbicideType == 'Dicamba') {
        file = "assets/markers/soybean-dicamba.png";
      } else if (herbicideType == 'Enlist') {
        file = "assets/markers/soybean-enlist.png";
      } else if (herbicideType == 'Roundup') {
        file = "assets/markers/soybean-roundup.png";
      } else if (herbicideType == 'Non-GMO') {
        file = "assets/markers/soybean-non-gmo.png";
      } else if (herbicideType == 'Organic') {
        file = "assets/markers/soybean-organic.png";
      }
    } else if (cropType == 'Wheat') {
      if (herbicideType == 'Dicamba') {
        file = "assets/markers/wheat-dicamba.png";
      } else if (herbicideType == 'Enlist') {
        file = "assets/markers/wheat-enlist.png";
      } else if (herbicideType == 'Roundup') {
        file = "assets/markers/wheat-roundup.png";
      } else if (herbicideType == 'Non-GMO') {
        file = "assets/markers/wheat-non-gmo.png";
      } else if (herbicideType == 'Organic') {
        file = "assets/markers/wheat-organic.png";
      }
    }

    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(58, 58)),
      file,
    );
  }

  Row _buildLegendRow({required String herbicideType, required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(herbicideType),
      ],
    );
  }

  Widget _buildLegend() {
    return Container(
      width: 150,
      height: 150,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Herbicide Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: herbicides
                    .map((herbicide) => _buildLegendRow(
                          herbicideType: herbicide.name,
                          color: herbicide.color,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addMarker(LatLng latLng) async {
    final cropType = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select type of field'),
            children: cropTypes
                .map(
                  (cropType) => SimpleDialogOption(
                    child: Text(cropType.name),
                    onPressed: () => Navigator.pop(context, cropType.name),
                  ),
                )
                .toList(),
          );
        });

    final herbicideType = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select type of herbicide'),
            children: herbicides
                .map(
                  (herbicide) => SimpleDialogOption(
                    child: Text(herbicide.name),
                    onPressed: () => Navigator.pop(context, herbicide.name),
                  ),
                )
                .toList(),
          );
        });

    final Marker marker = Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      infoWindow: InfoWindow(
        title: '$cropType field',
        snippet: 'This is a $cropType field',
      ),
      icon: await _getBitmap(
        cropType: cropType!,
        herbicideType: herbicideType!,
      ),
    );

    setState(() {
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            isAdding = true;
            appBarTitle = 'Tap location of field to add';
          });
        },
      ),
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: _kGooglePlex,
        onTap: (latLng) {
          if (isAdding) {
            _addMarker(latLng);
          }
        },
        markers: Set<Marker>.of(markers),
      ),
      // body: Stack(
      //   children: [
      //     GoogleMap(
      //       mapType: MapType.satellite,
      //       initialCameraPosition: _kGooglePlex,
      //       onMapCreated: (GoogleMapController controller) {
      //         _controller.complete(controller);
      //       },
      //       onLongPress: (latLng) {
      //         setState(() {
      //           appBarTitle = 'Pressed';
      //         });
      //         _addMarker(latLng);
      //       },
      //       onTap: (latLng) {
      //         setState(() {
      //           appBarTitle = 'Pressed';
      //         });
      //         _addMarker(latLng);
      //       },
      //       markers: Set<Marker>.of(markers),
      //     ),
      //     _buildLegend(),
      //   ],
      // ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();
  late ConfirmationResult confirmationResult;

  bool showAuthCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
      ),
      body: showAuthCode
          ? Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Column(
                children: [
                  TextField(
                    controller: smsCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Authentication code',
                      helperText:
                          'Enter the authentication code sent to your phone',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        confirmationResult.confirm(smsCodeController.text);
                      }),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Column(
                children: [
                  TextField(
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      helperText: 'Enter your phone number to login',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    child: const Text('Send auth code'),
                    onPressed: () async {
                      confirmationResult =
                          await FirebaseAuth.instance.signInWithPhoneNumber(
                        '+1${phoneNumberController.text}',
                      );
                      setState(() {
                        showAuthCode = true;
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
