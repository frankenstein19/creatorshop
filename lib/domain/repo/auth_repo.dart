import 'package:creator_shop/data/model/user_model.dart';
import 'package:creator_shop/domain/repo/i_auth_repo.dart';
import 'package:creator_shop/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../di/di_config.dart';

@devEnv
@prodEnv
@Injectable(as: IAuthRepo)
class AuthRepo extends IAuthRepo {
  @override
  Future<UserModel?> loginWithEmail(String email, String password) async {
    UserModel? userModel;
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        userModel = UserModel(
            email: userCredential.user?.email, uid: userCredential.user?.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast('Wrong password provided for that user.');
      }
    }
    return userModel;
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserModel?> loginWithGoogle() async {
    UserModel? userModel;

    /// Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    /// Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    /// Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    /// Once signed in, return the UserCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      userModel = UserModel(
          email: userCredential.user?.email, uid: userCredential.user?.uid);
    }
    return userModel;
  }

  @override
  /// authStateChanges is stream so we have to keep listen
  /// We will also convert firebase user to UserModel
  /// Then only we can create mock repo for this method
  Stream<UserModel?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges().map((event) =>
        event == null ? null : UserModel(email: event.email, uid: event.uid));
  }

  @override
  Future<String?> createAccount(String email, String password) async {
    String? userId;
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        userId = credential.user?.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      }
    } catch (e) {
      showToast(e.toString());
    }
    return userId;
  }
}
