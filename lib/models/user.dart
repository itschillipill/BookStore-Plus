// models/user.dart
class User {
  final String name;
  final String email;
  final String phone;

  User({required this.name, required this.email, required this.phone});

  factory User.appUser() => User(name: "Data", email: "data@data.com", phone: "+123456789");
}
