import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:root_gorge/fields_overview/fields_overview.dart';

class FieldsOverviewPage extends StatelessWidget {
  const FieldsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FieldsOverviewBloc(
        fieldsRepository: context.read<FieldsRepository>(),
      )..add(const FieldsOverviewSubscriptionRequested()),
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
                      content: Text('Error!'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<FieldsOverviewBloc, FieldsOverviewState>(
          builder: (context, state) {
            if (state.fields.isEmpty) {
              if (state.status == FieldsOverviewStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status != FieldsOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    'No fields found',
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }
            } else {
              return Stack(
                children: [
                  const GoogleMap(
                    initialCameraPosition: CameraPosition(
                      zoom: 16,
                      target: LatLng(40.51280238950735, -104.95310938820711),
                    ),
                  ),
                  Center(
                    child: Text('Number fields: ${state.fields.length}'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
