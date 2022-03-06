import 'package:bloc_test/bloc_test.dart';
import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:root_gorge/fields_overview/fields_overview.dart';

import '../../helpers/helpers.dart';

class MockFieldsRepository extends Mock implements FieldsRepository {}

class MockFieldsOverviewBloc
    extends MockBloc<FieldsOverviewEvent, FieldsOverviewState>
    implements FieldsOverviewBloc {}

void main() {
  final mockFields = [
    Field(
      id: '1',
      mapPoints: const [MarkerLatLng(1.23, 4.56)],
      beanType: 'bean type 1',
    ),
    Field(
      id: '2',
      mapPoints: const [MarkerLatLng(7.89, 1.91)],
      beanType: 'bean type 2',
    ),
    Field(
      id: '3',
      mapPoints: const [MarkerLatLng(1.45, 4.24)],
      beanType: 'bean type 3',
    )
  ];

  late FieldsRepository fieldsRepository;

  group('FieldsOverviewPage', () {
    setUp(() {
      fieldsRepository = MockFieldsRepository();
      when(fieldsRepository.getFields).thenAnswer((_) => const Stream.empty());
    });

    testWidgets('renders FieldsOverviewView', (tester) async {
      await tester.pumpApp(
        const FieldsOverviewPage(),
        fieldsRepository: fieldsRepository,
      );

      expect(find.byType(FieldsOverviewView), findsOneWidget);
    });

    testWidgets(
      'subscribes to fields from repository on initialization',
      (tester) async {
        await tester.pumpApp(
          const FieldsOverviewPage(),
          fieldsRepository: fieldsRepository,
        );

        verify(() => fieldsRepository.getFields()).called(1);
      },
    );
  });

  group(
    'FieldsOverviewView',
    () {
      late MockNavigator navigator;
      late FieldsOverviewBloc fieldsOverviewBloc;

      setUp(() {
        navigator = MockNavigator();
        when(() => navigator.push(any())).thenAnswer((_) async => null);

        fieldsOverviewBloc = MockFieldsOverviewBloc();

        when(() => fieldsOverviewBloc.state).thenReturn(
          FieldsOverviewState(
            status: FieldsOverviewStatus.success,
            fields: mockFields,
          ),
        );

        fieldsRepository = MockFieldsRepository();
        when(fieldsRepository.getFields)
            .thenAnswer((_) => const Stream.empty());
      });

      Widget buildSubject() {
        return MockNavigatorProvider(
          navigator: navigator,
          child: BlocProvider.value(
            value: fieldsOverviewBloc,
            child: const FieldsOverviewView(),
          ),
        );
      }

      testWidgets(
        'renders AppBar with title text',
        (tester) async {
          await tester.pumpApp(
            buildSubject(),
            fieldsRepository: fieldsRepository,
          );

          expect(find.byType(AppBar), findsOneWidget);
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text('Fields Overview'),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders error snackbar '
        'when status changes to failure',
        (tester) async {
          whenListen<FieldsOverviewState>(
            fieldsOverviewBloc,
            Stream.fromIterable([
              const FieldsOverviewState(),
              const FieldsOverviewState(
                status: FieldsOverviewStatus.failure,
              ),
            ]),
          );

          await tester.pumpApp(
            buildSubject(),
            fieldsRepository: fieldsRepository,
          );
          await tester.pumpAndSettle();

          expect(find.byType(SnackBar), findsOneWidget);
          expect(
            find.descendant(
              of: find.byType(SnackBar),
              matching: find.text('Error loading fields!'),
            ),
            findsOneWidget,
          );
        },
      );

      group(
        'when fields is empty',
        () {
          setUp(() {
            when(
              () => fieldsOverviewBloc.state,
            ).thenReturn(const FieldsOverviewState());
          });

          testWidgets(
            'renders nothing '
            'when status is initial or error',
            (tester) async {
              await tester.pumpApp(
                buildSubject(),
                fieldsRepository: fieldsRepository,
              );
              expect(find.byType(GoogleMap), findsOneWidget);
            },
          );

          testWidgets(
            'renders loading indicator '
            'when status is loading',
            (tester) async {
              when(() => fieldsOverviewBloc.state).thenReturn(
                const FieldsOverviewState(status: FieldsOverviewStatus.loading),
              );

              await tester.pumpApp(
                buildSubject(),
                fieldsRepository: fieldsRepository,
              );

              expect(find.byType(CircularProgressIndicator), findsOneWidget);
            },
          );
        },
      );
    },
  );
}
