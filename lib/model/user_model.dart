// lib/models/user_model.dart
class User {
  final String id;
  final String? name;
  final String? email;
  final String mobile;
  final String? profileImage;
  final String? role;

  User({
    required this.id,
    this.name,
    this.email,
    required this.mobile,
    this.profileImage,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'] ?? '',
      profileImage: json['profileImage'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'profileImage': profileImage,
      'role': role,
    };
  }
}