part of 'home_bloc.dart';

enum HomeStatus { intitial, failure, loading, success }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.intitial,
    this.fields = const [],
    this.markers = const [],
  });

  final HomeStatus status;
  final List<Field> fields;
  final List<Marker> markers;

  HomeState copyWith({
    HomeStatus? status,
    List<Field>? fields,
    List<Marker>? markers,
  }) {
    return HomeState(
      status: status ?? this.status,
      fields: fields ?? this.fields,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object> get props => [status, fields, markers];
}
