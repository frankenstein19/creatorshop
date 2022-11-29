import 'package:creator_shop/data/model/user_model.dart';
import 'package:creator_shop/domain/usecase/app_state_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state_event.dart';

part 'app_state_state.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppStateState> {
  AppStateBloc(this.appStateUseCase) : super(AppStateInitial()) {
    on<ListenAuthStateEvent>(onListenAuthState);
    on<UserAvailableAppStateEvent>(onUserAvailableAppStateEvent);
    on<UserNotAvailableAppStateEvent>(onUserNotAvailableAppStateEvent);
  }

  final AppStateUseCase appStateUseCase;

  void onListenAuthState(
      ListenAuthStateEvent event, Emitter<AppStateState> emitter) async {
    await emitter.onEach(appStateUseCase.listenAppStateChanges(),
        onData: (user) => user == null
            ? add(UserNotAvailableAppStateEvent())
            : add(UserAvailableAppStateEvent(user)));
  }

  void onUserAvailableAppStateEvent(
          UserAvailableAppStateEvent event, Emitter<AppStateState> emitter) =>
      emitter(UserAvailableState(event.userModel));

  void onUserNotAvailableAppStateEvent(UserNotAvailableAppStateEvent event,
          Emitter<AppStateState> emitter) =>
      emitter(UserNotAvailableState());
}
