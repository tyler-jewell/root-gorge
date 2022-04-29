import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final cropTypes = [
  {'label': 'Corn', 'avatarPath': 'assets/corn-logo.png'},
  {'label': 'Wheat', 'avatarPath': 'assets/wheat-logo.png'},
  {'label': 'Soybeans', 'avatarPath': 'assets/soybean-logo.png'},
  {'label': 'GMO', 'avatarPath': 'assets/gmo-logo.png'},
  {'label': 'Organic', 'avatarPath': 'assets/organic-logo.png'},
  {'label': 'Other', 'avatarPath': 'assets/corn-logo.png'}
];
final herbicideTypes = ['Dicamba', 'Enlist', 'Roundup', 'Other'];

class FieldMapView extends StatefulWidget {
  const FieldMapView({Key? key}) : super(key: key);

  @override
  State<FieldMapView> createState() => _FieldMapViewState();
}

class _FieldMapViewState extends State<FieldMapView> {
  late GoogleMapController _mapController;
  final PanelController _panelController = PanelController();

  late Location _location;

  bool _addingPoints = false;
  bool _showSettingsSheet = false;
  bool _panEnabled = true;
  String selectedCropType = '';
  String selectedHerbicideType = '';
  List<LatLng> fieldPoints = [];
  List<List<LatLng>> fields = [];

  LatLng initialPosition = const LatLng(40.6143552, -104.9526272);

  void _handleAddFieldButtonClicked() {
    setState(() {
      _addingPoints = true;
    });
  }

  void _handleMapTap(LatLng latLng) {
    if (_addingPoints) {
      setState(() {
        fieldPoints.add(latLng);
      });
    }
  }

  void _handleCancelAddField() {
    setState(() {
      fieldPoints = [];
      _addingPoints = false;
    });
  }

  void _handleSubmitFieldPoints() {
    setState(() {
      _addingPoints = false;
      _showSettingsSheet = true;
    });
  }

  Set<Polygon> _buildAllFields() {
    return fields
        .map(
          (points) => Polygon(
            polygonId: PolygonId(points.toString()),
            points: points,
            fillColor: Colors.blue.withOpacity(0.3),
            strokeColor: Colors.blue,
            strokeWidth: 2,
          ),
        )
        .toSet();
  }

  Set<Polygon> _buildNewField() {
    return {
      Polygon(
        polygonId: const PolygonId('new-field'),
        points: fieldPoints,
        fillColor: Colors.green.withOpacity(0.3),
        strokeColor: Colors.green,
        strokeWidth: 2,
      )
    };
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _location = Location();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final currentLocation = await _location.getLocation();

    await _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _addingPoints
            ? const Center(
                child: Text('Tap points around the boundary of the field'),
              )
            : const Text('Fields'),
        leading: _addingPoints
            ? const Padding(
                padding: EdgeInsets.all(8),
                child: CircleAvatar(
                  child: Icon(Icons.touch_app_rounded),
                ),
              )
            : Container(),
        actions: _addingPoints
            ? [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: _handleCancelAddField,
                    child: const Icon(Icons.close),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: _handleSubmitFieldPoints,
                    child: const Icon(
                      Icons.check,
                    ),
                  ),
                ),
              ]
            : [
                GestureDetector(
                  onTap: _handleAddFieldButtonClicked,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Icon(Icons.add), Text('Add field')],
                    ),
                  ),
                ),
              ],
      ),
      body: SlidingUpPanel(
        minHeight: 200,
        controller: _panelController,
        body: GoogleMap(
          zoomGesturesEnabled: _panEnabled,
          mapToolbarEnabled: false,
          onMapCreated: _onMapCreated,
          mapType: MapType.satellite,
          onTap: _handleMapTap,
          initialCameraPosition: CameraPosition(
            zoom: 16,
            target: initialPosition,
          ),
          polygons: _addingPoints || _showSettingsSheet
              ? _buildNewField()
              : _buildAllFields(),
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        panel: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Field type',
                style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: cropTypes
                    .map(
                      (Map<String, String> cropType) => ChoiceChip(
                        avatar: Image.asset(cropType['avatarPath']!),
                        selected: selectedCropType == cropType['label'],
                        label: Text(cropType['label']!),
                        onSelected: (_) {
                          setState(() {
                            selectedCropType = cropType['label']!;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),
              Text(
                'Herbicide type',
                style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: herbicideTypes
                    .map(
                      (String herbicideType) => FilterChip(
                        selected: selectedHerbicideType == herbicideType,
                        label: Text(herbicideType),
                        onSelected: (_) {
                          setState(() {
                            selectedHerbicideType = herbicideType;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        onPanelSlide: (double pos) {
          setState(() {
            _panEnabled = false;
            Timer(
              const Duration(seconds: 1),
              () => setState(() => _panEnabled = true),
            );
          });
        },
      ),
    );
  }
}
