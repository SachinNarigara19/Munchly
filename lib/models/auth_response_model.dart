class AuthResponseModel {
  final bool success;
  final String message;
  final String? token;
  final String? userId;
  final int statusCode;

  AuthResponseModel({
    required this.success,
    required this.message,
    this.token,
    this.userId,
    required this.statusCode,
  });

  factory AuthResponseModel.fromSuccessJson(Map<String, dynamic> json, int statusCode) {
    return AuthResponseModel(
      success: true,
      message: json['message']?.toString() ?? 'Operation completed successfully.',
      token: json['token']?.toString(),
      userId: json['userId']?.toString(),
      statusCode: statusCode,
    );
  }

  factory AuthResponseModel.fromErrorJson(Map<String, dynamic> json, int statusCode) {
    final errorMsg = json['error']?.toString() ??
        json['message']?.toString() ??
        'An unexpected error occurred. Please try again.';
    return AuthResponseModel(
      success: false,
      message: errorMsg,
      statusCode: statusCode,
    );
  }

  factory AuthResponseModel.fromException(String errorMessage, [int statusCode = 500]) {
    return AuthResponseModel(
      success: false,
      message: errorMessage,
      statusCode: statusCode,
    );
  }
}
