part of 'app_state_bloc.dart';

abstract class AppStateEvent extends Equatable {
  const AppStateEvent();
}

class ListenAuthStateEvent extends AppStateEvent {
  @override
  List<Object?> get props => [];
}

class UserAvailableAppStateEvent extends AppStateEvent {
  final UserModel userModel;

  const UserAvailableAppStateEvent(this.userModel);

  @override
  List<Object?> get props => [userModel.toString()];
}

class UserNotAvailableAppStateEvent extends AppStateEvent {
  @override
  List<Object?> get props => [];
}
