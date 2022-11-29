import 'package:creator_shop/data/model/user_model.dart';

abstract class IAuthRepo {
  /// This method will use for Login with Email and password
  /// This method will be used in Development as well as testing
  Future<UserModel?> loginWithEmail(String email, String password);

  /// SignOut will remove user from application
  /// Also it will reset the state
  /// This method will be used in Development as well as testing
  Future<void> signOut();

  /// This method will use for Google
  /// In this method we do not require any credential
  /// Also first we login in Google then from Google we will be sign in firebase
  /// This method will be used in Development as well as testing
  Future<UserModel?> loginWithGoogle();

  /// This method will listen User login and logout event
  /// It will return Firebase user
  Stream<UserModel?> authStateChanges();

  /// Create account using email and password
  /// After create account it will directly login
  /// so no need to user login
  Future<String?> createAccount(String email, String password);




}
