class UserEntity {
  final String? email;
  final String? id;
  final String? name;
  final String? photoUrl;
  final String? role;

  UserEntity(
      {required this.photoUrl,
      required this.email,
      required this.id,
      required this.name,
      required this.role});
}
