import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/app/app.dart';
import 'package:root_gorge/home/home.dart';
import 'package:root_gorge/repositories/fields/fields.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          fieldsRepository: context.read<FieldsRepository>(),
        )..add(
            FieldsRequested(devicePixelRatio: devicePixelRatio),
          ),
        child: const MapWidget(),
      ),
    );
  }
}
