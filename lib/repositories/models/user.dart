class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.token});

  // implement the empty constructor
  static UserModel empty = UserModel(id: '', name: '', email: '', token: '');

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['adm_number'],
      token: json['token'],
      name: json['first_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adm_number': id,
      'first_name': name,
      'token': token,
      'email': email,
    };
  }
}
