import 'package:creator_shop/data/model/user_model.dart';

abstract class IUserRepo{
  Future<bool> addUserInfo(UserModel user);

  Future<UserModel?> getUserInfo(String userId);
}