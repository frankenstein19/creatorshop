part of 'create_account_bloc.dart';

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();
}

class CreateNewAccount extends CreateAccountEvent{
  @override
  List<Object?> get props => [];
}
class UserDataChangeEvent extends CreateAccountEvent{
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? uid;
  final String? role;

  const UserDataChangeEvent(
      {this.email,
       this.password,
      this.firstName,
      this.lastName,
      this.mobile,
      this.uid,
      this.role});
  @override
  List<Object?> get props => [email,password,firstName,lastName,role,mobile];
}


