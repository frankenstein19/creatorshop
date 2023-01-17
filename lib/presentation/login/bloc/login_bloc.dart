import 'package:creator_shop/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/login_screen_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.loginScreenUseCase) : super(const LoginState()) {
    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<OnLoginEvent>(_onLogin);
    on<OnLoginWithGoogleEvent>(_onOnLoginWithGoogleEvent);
  }

  final LoginScreenUseCase loginScreenUseCase;
  VoidCallback? onLoginSuccess;

  void _onEmailChanged(EmailChangedEvent event, Emitter<LoginState> emit) {
    final email = event.email;
    emit(state.copyWith(
        email: email,
        state: email.isNotEmpty &&
                email.isEmailValid &&
                state.password.isNotEmpty &&
                state.password.isPasswordValid
            ? LoginButtonState.enable
            : LoginButtonState.disable,
        canLogin:
            email.isNotEmpty && state.password.isNotEmpty ? true : false));
  }

  void _onPasswordChanged(
      PasswordChangedEvent event, Emitter<LoginState> emit) {
    final password = event.password;
    emit(state.copyWith(
        password: password,
        state: password.isNotEmpty &&
                password.isPasswordValid &&
                state.email.isNotEmpty &&
                state.email.isEmailValid
            ? LoginButtonState.enable
            : LoginButtonState.disable,
        canLogin:
            password.isNotEmpty && state.email.isNotEmpty ? true : false));
  }

  Future<void> _onLogin(OnLoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
        email: state.email,
        password: state.password,
        state: LoginButtonState.progress,
        canLogin: false));
    if (await loginScreenUseCase.onLogin(state.email, state.password)) {}
    emit(state.copyWith(
        state: LoginButtonState.enable,
        canLogin: false,
        email: "",
        password: ""));
  }

  void _onOnLoginWithGoogleEvent(
      OnLoginWithGoogleEvent event, Emitter<LoginState> emit) async {
    await loginScreenUseCase.onLoginWithGoogle();
  }
}
