class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final DateTime? createdAt;

  const UserModel({this.id, this.name, this.email, this.role, this.createdAt});

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      createdAt: DateTime.tryParse(json["createdAt"].toString()),
    );
  }
}
