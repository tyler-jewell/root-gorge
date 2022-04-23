import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FieldMapView extends StatefulWidget {
  const FieldMapView({Key? key}) : super(key: key);

  @override
  State<FieldMapView> createState() => _FieldMapViewState();
}

class _FieldMapViewState extends State<FieldMapView> {
  late GoogleMapController _mapController;
  late Location _location;

  bool _showAddPointsBanner = false;
  bool _showSettingsSheet = false;
  List<LatLng> fieldPoints = [];
  List<List<LatLng>> fields = [];

  LatLng initialPosition = const LatLng(40.6143552, -104.9526272);

  void _handleAddFieldButtonClicked() {
    setState(() {
      print('clicked');
      _showAddPointsBanner = true;
    });
  }

  void _handleMapTap(LatLng latLng) {
    print('tapped');
    if (_showAddPointsBanner) {
      print('add tapped');
      setState(() {
        fieldPoints.add(latLng);
      });
    }
  }

  void _handleCancelAddField() {
    setState(() {
      fieldPoints = [];
      _showAddPointsBanner = false;
    });
  }

  void _handleSubmitFieldPoints() {
    setState(() {
      // fields.add(fieldPoints);
      // fieldPoints = [];
      _showAddPointsBanner = false;
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
    print('created');
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
    print('build');
    return Scaffold(
      body: Column(
        children: [
          if (_showAddPointsBanner)
            MaterialBanner(
              content: Text(
                'Tap points around the boundary of the field',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              leading: const CircleAvatar(
                child: Icon(Icons.touch_app_rounded),
              ),
              actions: [
                TextButton(
                  onPressed: _handleCancelAddField,
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: _handleSubmitFieldPoints,
                  child: const Text('Submit'),
                ),
              ],
            ),
          Flexible(
            child: GoogleMap(
              mapToolbarEnabled: false,
              onMapCreated: _onMapCreated,
              mapType: MapType.satellite,
              onTap: _handleMapTap,
              initialCameraPosition: CameraPosition(
                zoom: 16,
                target: initialPosition,
              ),
              polygons: _showAddPointsBanner || _showSettingsSheet
                  ? _buildNewField()
                  : _buildAllFields(),
            ),
          ),
          if (_showSettingsSheet)
            SlidingUpPanel(
              panel: const Center(
                child: Text('This is sliding up'),
              ),
            ),
        ],
      ),
      floatingActionButton: _showAddPointsBanner || _showSettingsSheet
          ? null
          : FloatingActionButton(
              onPressed: _handleAddFieldButtonClicked,
              child: const Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
