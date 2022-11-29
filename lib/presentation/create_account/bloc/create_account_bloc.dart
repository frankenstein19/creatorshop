import 'package:creator_shop/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/create_account_usecase.dart';

part 'create_account_event.dart';

part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc(this.createAccountUseCase)
      : super(const CreateAccountState()) {
    on<UserDataChangeEvent>(_onUserDataChange);
    on<CreateNewAccount>(_onCreateAccountEvent);
  }

  final CreateAccountUseCase createAccountUseCase;

  void _onUserDataChange(
      UserDataChangeEvent event, Emitter<CreateAccountState> emitter) {
    emitter(state.copyWith(
      email: event.email,
      password: event.password,
      firstName: event.firstName,
      lastName: event.lastName,
      mobile: event.mobile,
      role: 'customer',
    ));

    /// validate all information
    emitter(state.copyWith(
        canCreateAccount: state.email.isEmailValid &&
            state.password.isPasswordValid &&
            state.mobile.validateMobile &&
            state.firstName.validateInfo &&
            state.lastName.validateInfo));
  }

  Future<void> _onCreateAccountEvent(
      CreateNewAccount event, Emitter<CreateAccountState> emitter) async {
    emitter(state.copyWith(inProgress: true));
    await createAccountUseCase.createAccount(
        state.email ?? "",
        state.password ?? "",
        state.firstName ?? "",
        state.lastName ?? "",
        state.mobile ?? "",
        state.role ?? "");
  }
}
