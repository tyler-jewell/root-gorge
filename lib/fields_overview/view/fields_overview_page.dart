import 'package:field_google_map/field_google_map.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/add_field/view/view.dart';
import 'package:root_gorge/fields_overview/fields_overview.dart';

class FieldsOverviewPage extends StatelessWidget {
  const FieldsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FieldsOverviewBloc(
            fieldsRepository: context.read<FieldsRepository>(),
          )..add(const FieldsOverviewSubscriptionRequested()),
        ),
      ],
      child: const FieldsOverviewView(),
    );
  }
}

class FieldsOverviewView extends StatelessWidget {
  const FieldsOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fields Overview'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(AddFieldPage.route());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: MultiBlocListener(
        listeners: [
          BlocListener<FieldsOverviewBloc, FieldsOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == FieldsOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Error loading fields!'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<FieldsOverviewBloc, FieldsOverviewState>(
          builder: (context, state) {
            if (state.status == FieldsOverviewStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return FieldGoogleMap(
                fields: state.fields,
                onTap: (latLng) {},
              );
            }
          },
        ),
      ),
    );
  }
}
