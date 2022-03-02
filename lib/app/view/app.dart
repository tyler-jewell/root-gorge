// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/bloc/map_bloc.dart';
import 'package:root_gorge/l10n/l10n.dart';
import 'package:root_gorge/map_repository.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.mapRepository}) : super(key: key);

  final MapRepository mapRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: mapRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc(
        mapRepository: context.read<MapRepository>(),
      )..add(MapSubscriptionRequested()),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: _Map(),
      ),
    );
  }
}

class _Map extends StatelessWidget {
  const _Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is MapLoaded) {
          print('build map');
          return GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: const CameraPosition(
              target: LatLng(40.512816339002, -104.95348635954223),
              zoom: 20,
            ),
            // polylines: state.polylines,
            polygons: state.polygons,
            onTap: (latLng) {
              print('${state.polygons.first.points}');

              final _newPoints = [...state.polygons.first.points, latLng];
              print('$_newPoints');
              state.polygons.first.points.add(latLng);
              final _polygon = Polygon(
                polygonId: const PolygonId('2'),
                consumeTapEvents: true,
                strokeWidth: 2,
                fillColor: Colors.grey.withOpacity(0.5),
                points: _newPoints,
              );
              print('adding polygon');
              context.read<MapBloc>().add(AddPolygon(_polygon));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
