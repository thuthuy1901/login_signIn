class User {
  String? id;
  String? nameUser;
  String? password;

  User({this.id, this.nameUser, this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUser = json['name'];
    password = json['password'];
  }
}
