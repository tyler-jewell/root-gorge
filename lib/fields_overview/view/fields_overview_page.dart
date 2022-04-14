import 'package:field_google_map/field_google_map.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root_gorge/edit_field/view/edit_field_page.dart';
import 'package:root_gorge/fields_overview/fields_overview.dart';

class FieldsOverviewPage extends StatelessWidget {
  const FieldsOverviewPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => FieldsOverviewBloc(
          fieldsRepository: context.read<FieldsRepository>(),
        ),
        child: const FieldsOverviewPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Be a neighbor'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'account',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(EditFieldPage.route());
        },
        isExtended: true,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocBuilder<FieldsOverviewBloc, FieldsOverviewState>(
        builder: (context, state) {
          if (state.status == FieldsOverviewStatus.loading ||
              state.status == FieldsOverviewStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return FieldGoogleMap(
              fields: state.fields,
              onTap: (latLng) {},
            );
          }
        },
      ),
    );
  }
}
