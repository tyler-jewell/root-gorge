import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/fields_overview/fields_overview.dart';
import 'package:root_gorge/fields_overview/widgets/fields_map.dart';
import 'package:root_gorge/repository/fields_repository.dart';

class FieldsOverviewPage extends StatelessWidget {
  const FieldsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FieldsOverviewBloc(
        fieldsRepository: context.read<FieldsRepository>(),
      )..add(const FieldsOverviewSubscriptionRequested()),
      child: BlocListener<FieldsOverviewBloc, FieldsOverviewState>(
        listener: (context, state) {
          if (state.status == FieldsOverviewStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Awesome Snackbar!'),
              ),
            );
          }
        },
        child: const FieldsOverviewView(),
      ),
    );
  }
}

class FieldsOverviewView extends StatelessWidget {
  const FieldsOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Field Overview'),
      ),
      body: BlocBuilder<FieldsOverviewBloc, FieldsOverviewState>(
        builder: (context, state) {
          if (state.status == FieldsOverviewStatus.loading ||
              state.status == FieldsOverviewStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return FieldsMap(fields: state.fields);
          }
        },
      ),
    );
  }
}
