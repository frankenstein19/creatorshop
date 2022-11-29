part of 'app_state_bloc.dart';

abstract class AppStateState extends Equatable {
  const AppStateState();
}

class AppStateInitial extends AppStateState {
  @override
  List<Object> get props => [];
}

class UserAvailableState extends AppStateState {
 final UserModel user;

  const UserAvailableState(this.user);
  @override
  List<Object> get props => [user.toJson()];
}

class UserNotAvailableState extends AppStateState {
  @override
  List<Object> get props => [];
}


