import 'package:app_clean_arch/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
  );

  UserModel copyWith({String? id, String? name, String? email}) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};
}
