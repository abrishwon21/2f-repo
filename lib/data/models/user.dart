class UserModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json["email"],
        password = json["password"],
        phone = json["phone"];
}
