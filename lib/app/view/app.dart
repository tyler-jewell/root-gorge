import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_gorge/fields_overview/fields_overview.dart';
import 'package:root_gorge/repository/fields_repository.dart';
import 'package:root_gorge/repository/location_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.locationRepository,
    required this.fieldsRepository,
  }) : super(key: key);

  final LocationRepository locationRepository;
  final FieldsRepository fieldsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: locationRepository,
        ),
        RepositoryProvider.value(
          value: fieldsRepository,
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
      ),
      home: const FieldsOverviewPage(),
    );
  }
}
