class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? type;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      type: json['user']['type'],
      token: json['token'],
    );
  }
}
