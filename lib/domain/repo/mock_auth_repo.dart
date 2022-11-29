import 'dart:async';

import 'package:creator_shop/data/model/user_model.dart';
import 'package:creator_shop/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

// ignore: depend_on_referenced_packages
import 'package:mockito/mockito.dart';

import '../../di/di_config.dart';

@testEnv
@Injectable(as: IAuthRepo)
class MockAuthRepo extends Mock implements IAuthRepo {
  StreamController<UserModel?> authStateStream = StreamController.broadcast();

  @override

  /// This method is mock method for Login
  /// Email should be rahul@gmail.com and password should be 123456 then only it will success
  /// otherwise it will return null
  Future<UserModel?> loginWithEmail(String email, String password) async {
    UserModel? userModel;
    if (email == "rahul@gmail.com" && password == "123456") {
      userModel = UserModel(email: email, uid: "00000");
      authStateStream.add(userModel);
    }
    return userModel;
  }

  @override
  Future<void> signOut() async {
    authStateStream.add(null);
    return Future.value(null);
  }

  @override

  /// authStateChanges is stream so we have to keep listen
  /// In mock authStateChanges we have used mock stream
  /// mock stream  will take data from mock login and sign out
  Stream<UserModel?> authStateChanges() {
    return authStateStream.stream;
  }

  /// It will create user login for any credentials
  @override
  Future<String?> createAccount(String email, String password) async {
    UserModel userModel = UserModel(email: email, uid: "00000");
    authStateStream.add(userModel);
    return userModel.uid;
  }
}
