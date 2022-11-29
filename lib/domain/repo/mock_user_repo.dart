import 'package:creator_shop/domain/repo/i_user_repo.dart';
import 'package:injectable/injectable.dart';

// ignore: depend_on_referenced_packages
import 'package:mockito/mockito.dart';

import '../../data/model/user_model.dart';
import '../../di/di_config.dart';

@testEnv
@Injectable(as: IUserRepo)
class MockUserRepo extends Mock implements IUserRepo {
  @override
  Future<bool> addUserInfo(UserModel user) async {
    return Future.value(true);
  }

  @override
  Future<UserModel?> getUserInfo(String userId) async {
    return UserModel(
        email: "rahul@gmail.com",
        firstName: 'Rahul',
        lastName: 'sharma',
        mobile: "8980497888",
        uid: "000000",
        role: "customer");
  }
}
