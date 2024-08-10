
import '../entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.photoUrl,
      required super.email,
      required super.id,
      required super.name,
      required super.role});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        email: map['email'] ?? '',
        name: map['username'] ?? '',
        id: map['uid'] ?? '',
        photoUrl: map['photoUrl']??'',
        role: map['role']);
  }

  UserModel copyWith(
      {String? id, String? name, String? email, String? photoUrl,String? role}) {
    return UserModel(
        email: email ?? this.email,
        role: role ?? this.role,
        name: name ?? this.name,
        id: id ?? this.id,
        photoUrl: photoUrl ?? this.photoUrl);
  }
}
