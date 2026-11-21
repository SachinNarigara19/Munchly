import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../models/auth_response_model.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

class AuthService {
  final Dio _dio;

  AuthService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConstants.baseUrl,
                connectTimeout: ApiConstants.connectTimeout,
                receiveTimeout: ApiConstants.receiveTimeout,
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
                validateStatus: (status) {
                  // Allow up to 500 to handle client error responses safely
                  return status != null && status < 500;
                },
              ),
            );

  Future<AuthResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiConstants.loginEndpoint,
        data: request.toJson(),
      );

      final statusCode = response.statusCode ?? 200;
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (statusCode >= 200 && statusCode < 300) {
          return AuthResponseModel.fromSuccessJson(data, statusCode);
        } else {
          return AuthResponseModel.fromErrorJson(data, statusCode);
        }
      }

      if (statusCode >= 200 && statusCode < 300) {
        return AuthResponseModel(
          success: true,
          message: 'Login successful.',
          statusCode: statusCode,
        );
      } else {
        return AuthResponseModel(
          success: false,
          message: 'Invalid response from server.',
          statusCode: statusCode,
        );
      }
    } on DioException catch (e) {
      return _handleDioException(e);
    } catch (e) {
      return AuthResponseModel.fromException(
        'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiConstants.registerEndpoint,
        data: request.toJson(),
      );

      final statusCode = response.statusCode ?? 200;
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (statusCode >= 200 && statusCode < 300) {
          return AuthResponseModel.fromSuccessJson(data, statusCode);
        } else {
          return AuthResponseModel.fromErrorJson(data, statusCode);
        }
      }

      if (statusCode >= 200 && statusCode < 300) {
        return AuthResponseModel(
          success: true,
          message: 'Registration successful.',
          statusCode: statusCode,
        );
      } else {
        return AuthResponseModel(
          success: false,
          message: 'Invalid response from server.',
          statusCode: statusCode,
        );
      }
    } on DioException catch (e) {
      return _handleDioException(e);
    } catch (e) {
      return AuthResponseModel.fromException(
        'An unexpected error occurred. Please try again.',
      );
    }
  }

  AuthResponseModel _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AuthResponseModel.fromException(
          'Connection timed out. Please check your internet connection.',
          408,
        );
      case DioExceptionType.badResponse:
        final response = e.response;
        if (response?.data is Map<String, dynamic>) {
          return AuthResponseModel.fromErrorJson(
            response!.data as Map<String, dynamic>,
            response.statusCode ?? 500,
          );
        }
        return AuthResponseModel.fromException(
          'Server returned an error (${response?.statusCode ?? 500}). Please try again later.',
          response?.statusCode ?? 500,
        );
      case DioExceptionType.connectionError:
        return AuthResponseModel.fromException(
          'Unable to connect to the server. Please check your internet connection.',
          503,
        );
      case DioExceptionType.cancel:
        return AuthResponseModel.fromException('Request was cancelled.', 499);
      default:
        return AuthResponseModel.fromException(
          'A network error occurred. Please try again.',
          500,
        );
    }
  }
}
