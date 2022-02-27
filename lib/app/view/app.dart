// Copyright (c) 2022, Mezops
// https://mezops.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marker_repository/marker_repository.dart';
import 'package:root_gorge/l10n/l10n.dart';
import 'package:root_gorge/map/bloc/map_bloc.dart';
import 'package:root_gorge/map/view/map_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.markerRepository,
  }) : super(key: key);

  final MarkerRepository markerRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: markerRepository,
      child: BlocProvider(
        create: (_) => MapBloc(),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const MapPage(),
    );
  }
}
