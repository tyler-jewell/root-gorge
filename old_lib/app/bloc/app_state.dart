part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;

  AppState copyWith({
    AppStatus? status,
    User? user,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [status, user];
}
