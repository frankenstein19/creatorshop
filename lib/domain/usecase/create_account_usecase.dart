import 'package:creator_shop/data/model/user_model.dart';
import 'package:creator_shop/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../di/di_config.dart';
import '../repo/i_user_repo.dart';

@devEnv
@prodEnv
@testEnv
@injectable
class CreateAccountUseCase {
  final IAuthRepo authRepo;
  final IUserRepo userRepo;

  CreateAccountUseCase(this.authRepo, this.userRepo);

  Future<void> createAccount(String email, String password, String? firstName,
      String? lastName, String? mobile, String? role) async {
    /// Creating user account with [email,password]
    /// It return user if it is successful
    final userId = await authRepo.createAccount(email, password);

    if (userId != null) {
      /// If user created successfully
      /// then will will store user info into database
      await userRepo.addUserInfo(UserModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          mobile: mobile,
          role: role,
          uid: userId));
    }
  }
}

