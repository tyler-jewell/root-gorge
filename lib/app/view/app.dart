import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/home/home.dart';

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
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
