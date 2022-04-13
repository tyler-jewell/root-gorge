import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/fields_overview/view/fields_overview_page.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.fieldsRepository}) : super(key: key);

  final FieldsRepository fieldsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: fieldsRepository,
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
