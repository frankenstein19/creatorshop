import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? uid;
  final String? role;

  UserModel(
      {this.email,
      this.firstName,
      this.lastName,
      this.mobile,
      this.uid,
      this.role});

  UserModel copyWith(String? email, String? firstName, String? lastName,
          String? mobile, String? uid, String? role) =>
      UserModel(
          email: email ?? this.email,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          mobile: mobile ?? this.mobile,
          uid: uid ?? this.uid,
          role: role ?? this.role);

  factory UserModel.fromJson(DocumentSnapshot json) => UserModel(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobile: json["mobile"],
        uid: json["uid"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "uid": uid,
        "role": role
      };
}
