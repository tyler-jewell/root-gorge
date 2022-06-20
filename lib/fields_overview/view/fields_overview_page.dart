import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_gorge/fields_overview/fields_overview.dart';
import 'package:root_gorge/fields_overview/widgets/fields_map.dart';
import 'package:root_gorge/repository/fields_repository.dart';
import 'package:root_gorge/repository/location_repository.dart';

class FieldsOverviewPage extends StatelessWidget {
  const FieldsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FieldsOverviewBloc(
        locationRepository: context.read<LocationRepository>(),
        fieldsRepository: context.read<FieldsRepository>(),
      )
        ..add(const UserLocationRequested())
        ..add(const FieldSubscriptionRequested()),
      child: const FieldsOverviewView(),
    );
  }
}

class FieldsOverviewView extends StatelessWidget {
  const FieldsOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fields')),
      body: BlocBuilder<FieldsOverviewBloc, FieldsOverviewState>(
        builder: (context, state) {
          if (state.status == FieldsOverviewStatus.loading ||
              state.status == FieldsOverviewStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const FieldsMap();
          }
        },
      ),
    );
  }
}
