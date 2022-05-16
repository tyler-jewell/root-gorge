import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Field {
  Field({
    required this.fieldId,
    required this.cropType,
    required this.herbicideType,
    required this.fieldPoints,
  });

  final String fieldId;
  final String cropType;
  final String herbicideType;
  final List<LatLng> fieldPoints;
}

List<Field> fields = [
  Field(
    fieldId: 'field-a',
    cropType: 'Corn',
    herbicideType: 'Dicamba',
    fieldPoints: [
      const LatLng(40.5139070994143, -104.95444389369341),
      const LatLng(40.51599126423923, -104.9548347418383),
      const LatLng(40.514743016149815, -104.95045813109728)
    ],
  ),
];

class FieldMapView extends StatefulWidget {
  const FieldMapView({Key? key}) : super(key: key);

  @override
  State<FieldMapView> createState() => _FieldMapViewState();
}

class _FieldMapViewState extends State<FieldMapView> {
  late GoogleMapController _mapController;
  final PanelController _panelController = PanelController();

  late Location _location;

  bool _editingField = false;
  bool _addingPoints = false;
  bool _panEnabled = true;

  String selectedCropType = '';
  String selectedHerbicideType = '';

  List<LatLng> fieldPoints = [];

  LatLng initialPosition = const LatLng(40.6143552, -104.9526272);

  void _handleAddField() {
    setState(() {
      _editingField = true;
      _addingPoints = true;
    });
  }

  void _handleMapTap(LatLng latLng) {
    if (_addingPoints && _editingField) {
      setState(() {
        fieldPoints.add(latLng);
      });
    }
  }

  void _handleCancelAddField() {
    setState(() {
      fieldPoints = [];
      _editingField = false;
      _addingPoints = false;
    });
  }

  void _handleSubmitFieldPoints() {
    setState(() {
      _addingPoints = false;
      _panelController.open();
    });
  }

  void _handleSaveField() {
    // setState(() {
    //   fields.add(fieldPoints);
    //   fieldPoints = [];

    //   _editingField = false;
    // });
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

  Set<Polygon> _buildAllFields() {
    return fields.map((field) {
      return Polygon(
        polygonId: PolygonId(field.fieldId),
        points: field.fieldPoints,
        fillColor: Colors.green.withOpacity(0.3),
        strokeColor: Colors.green,
        strokeWidth: 2,
      );
    }).toSet();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _location = Location();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final currentLocation = await _location.getLocation();

    initialPosition = LatLng(
      currentLocation.latitude!,
      currentLocation.longitude!,
    );

    await _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        ),
      ),
    );
  }

  Widget _tapDialog() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 10,
              child: Icon(
                Icons.touch_app_rounded,
                size: 15,
              ),
            ),
            SizedBox(width: 8),
            Text('Tap points around the boundary of the field'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _handleCancelAddField,
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: _handleSubmitFieldPoints,
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fieldSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Field type',
          style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [Text('Fix this')],
          // children: cropTypes
          //     .map(
          //       (String cropType) => FilterChip(
          //         selected: selectedCropType == cropType,
          //         label: Text(cropType),
          //         onSelected: (_) {
          //           setState(() {
          //             selectedCropType = cropType;
          //           });
          //         },
          //       ),
          //     )
          //     .toList(),
        ),
        const SizedBox(height: 8),
        Text(
          'Herbicide type',
          style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [Text('Fix this')],
          // children: herbicideTypes
          //     .map(
          //       (String herbicideType) => FilterChip(
          //         selected: selectedHerbicideType == herbicideType,
          //         label: Text(herbicideType),
          //         onSelected: (_) {
          //           setState(() {
          //             selectedHerbicideType = herbicideType;
          //           });
          //         },
          //       ),
          //     )
          //     .toList(),
        ),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    MediaQuery.of(context).size.width * 0.6,
                    40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: _handleSaveField,
                child: const Text('Save Field'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _handleCancelAddField,
                child: const Text('Cancel'),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _googleMap({required Set<Polygon> polygons}) {
    return GoogleMap(
      zoomGesturesEnabled: _panEnabled,
      mapToolbarEnabled: false,
      onMapCreated: _onMapCreated,
      mapType: MapType.satellite,
      onTap: _handleMapTap,
      initialCameraPosition: CameraPosition(
        zoom: 16,
        target: initialPosition,
      ),
      polygons: polygons,
    );
  }

  Widget _editFieldView() {
    return SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * 0.4,
      controller: _panelController,
      body: _googleMap(polygons: _buildNewField()),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(10),
      ),
      panelBuilder: (sc) => ListView(
        padding: const EdgeInsets.all(8),
        controller: sc,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_addingPoints) _tapDialog() else _fieldSettings(),
        ],
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
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _editingField ? 'Edit Field' : 'Field Overview',
          ),
        ),
        actions: _editingField
            ? null
            : [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _handleAddField,
                ),
              ],
      ),
      body: _editingField
          ? _editFieldView()
          : _googleMap(
              polygons: _buildAllFields(),
            ),
    );
  }
}
