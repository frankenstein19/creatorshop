part of 'create_account_bloc.dart';

class CreateAccountState extends Equatable {
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? uid;
  final String? role;
  final bool canCreateAccount;
  final bool inProgress;

  const CreateAccountState(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.mobile,
      this.uid,
      this.role,
      this.canCreateAccount = false,
      this.inProgress = false});

  CreateAccountState copyWith(
      {String? email,
      String? password,
      String? firstName,
      String? lastName,
      String? mobile,
      String? uid,
      String? role,
      bool? inProgress,
      bool? canCreateAccount}) {
    return CreateAccountState(
        email: email ?? this.email,
        password: password ?? this.password,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        mobile: mobile ?? this.mobile,
        uid: uid ?? this.uid,
        role: role ?? this.role,
        inProgress: inProgress ?? this.inProgress,
        canCreateAccount: canCreateAccount ?? this.canCreateAccount);
  }

  @override
  List<Object?> get props => [
        email,
        password,
        firstName,
        lastName,
        mobile,
        uid,
        role,
        canCreateAccount
      ];
}
