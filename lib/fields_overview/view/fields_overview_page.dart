import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/add_field/view/view.dart';
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
      floatingActionButton:
          BlocListener<FieldsOverviewBloc, FieldsOverviewState>(
        listenWhen: (previous, current) =>
            previous.editingField != current.editingField,
        listener: (context, state) {
          final editingField = state.editingField;
        },
        child: FloatingActionButton(
          onPressed: () => editingField
              ? context
                  .read<FieldsOverviewBloc>()
                  .add(const EditFieldRequested())
              : context
                  .read<FieldsOverviewBloc>()
                  .add(const EditFieldRequested()),
          child: context.read<FieldsOverviewBloc>().state.editingField
              ? const Icon(Icons.check)
              : const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        title: const Text('Fields'),
      ),
      body: BlocBuilder<FieldsOverviewBloc, FieldsOverviewState>(
        builder: (context, state) {
          if (state.status == FieldsOverviewStatus.loading ||
              state.status == FieldsOverviewStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.editingField == true) {
            return const FieldsMap(editing: true);
          } else {
            return const FieldsMap(editing: false);
          }
        },
      ),
    );
  }
}
