class LoginRequestModel {
  final String identifier;
  final String password;

  LoginRequestModel({
    required this.identifier,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'identifier': identifier.trim(),
    'password': password,
  };
}

class LoginResponseModel {
  final String? userId;
  final String? token;
  final String? message;

  LoginResponseModel({
    this.userId,
    this.token,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      userId: json['userId']?.toString(),
      token: json['token']?.toString(),
      message: json['message']?.toString(),
    );
  }
}
