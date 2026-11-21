class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String mobile;
  final String gender;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.mobile,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
    'name': name.trim(),
    'email': email.trim(),
    'password': password,
    'mobile': mobile.trim(),
    'gender': gender.toLowerCase().trim(),
  };
}

class RegisterResponseModel {
  final String? token;
  final String? message;

  RegisterResponseModel({
    this.token,
    this.message,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      token: json['token']?.toString(),
      message: json['message']?.toString(),
    );
  }
}
