import 'package:creator_shop/data/model/user_model.dart';
import 'package:creator_shop/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../di/di_config.dart';
import '../repo/i_user_repo.dart';

@devEnv
@prodEnv
@testEnv
@injectable
class AppStateUseCase {
  final IAuthRepo authRepo;
  final IUserRepo userRepo;

  AppStateUseCase(this.authRepo, this.userRepo);

  /// This method will listen user changes
  /// if user is available then it will try to fetch user info
  Stream<UserModel?> listenAppStateChanges() async* {
    await for (UserModel? state in authRepo.authStateChanges()) {
      if (state == null) {
        yield null;
      } else {
        yield await fetchUserinfo(state);
      }
    }
  }

  /// Current this method is not yet developed
  Future<UserModel?> fetchUserinfo(UserModel model) async {
    final userInfo = await userRepo.getUserInfo(model.uid ?? "");
    return userInfo;
  }
}
