import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creator_shop/data/model/user_model.dart';
import 'package:creator_shop/domain/repo/i_user_repo.dart';
import 'package:injectable/injectable.dart';

import '../../di/di_config.dart';

@devEnv
@prodEnv
@Injectable(as: IUserRepo)
class UserRepo extends IUserRepo {
  @override
  Future<bool> addUserInfo(UserModel user) async {
    bool userInfoAdded = true;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set(user.toJson())
        .catchError((error) => userInfoAdded = false);

    return userInfoAdded;
  }

  @override
  Future<UserModel?> getUserInfo(String userId) async {
    UserModel? userModel;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userModel = UserModel.fromJson(documentSnapshot);
      }
    });
    return userModel;
  }
}
