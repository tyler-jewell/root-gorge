part of 'home_bloc.dart';

enum HomeStatus { intitial, failure, loading, success }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.intitial,
    this.fields = const [],
  });

  final HomeStatus status;
  final List<Field> fields;

  HomeState copyWith({
    HomeStatus? status,
    List<Field>? fields,
  }) {
    return HomeState(
      status: status ?? this.status,
      fields: fields ?? this.fields,
    );
  }

  @override
  List<Object> get props => [status, fields];
}
