import 'package:creator_shop/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../di/di_config.dart';

@devEnv
@prodEnv
@testEnv
@injectable
class LoginScreenUseCase {
  final IAuthRepo authRepo;

  LoginScreenUseCase(this.authRepo);

  ///
  Future<bool> onLogin(String email, String password) async {
    final user = await authRepo.loginWithEmail(email, password);
    if(user!=null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onLoginWithGoogle() async {
    final user = await authRepo.loginWithGoogle();
    if(user!=null) {
      return true;
    } else {
      return false;
    }
  }
}
