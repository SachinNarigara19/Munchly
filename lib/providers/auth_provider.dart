import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  static const String _tokenPrefKey = 'munchly_auth_token';
  static const String _userEmailPrefKey = 'munchly_user_email';
  static const String _userNamePrefKey = 'munchly_user_name';

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  String? _token;
  String? _userEmail;
  String? _userName;

  AuthProvider({AuthService? authService})
      : _authService = authService ?? AuthService();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  String? get token => _token;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  Future<void> initSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString(_tokenPrefKey);
      _userEmail = prefs.getString(_userEmailPrefKey);
      _userName = prefs.getString(_userNamePrefKey);
      notifyListeners();
    } catch (_) {}
  }

  Future<bool> login({
    required String identifier,
    required String password,
  }) async {
    if (_isLoading) return false;

    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await _authService.login(
        LoginRequestModel(identifier: identifier, password: password),
      );

      _isLoading = false;

      if (response.success) {
        _token = response.token;
        _userEmail = identifier;
        _successMessage = response.message;

        final prefs = await SharedPreferences.getInstance();
        if (_token != null) {
          await prefs.setString(_tokenPrefKey, _token!);
        }
        await prefs.setString(_userEmailPrefKey, identifier);

        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        notifyListeners();
        return false;
      }
    } catch (_) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred during login.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String mobile,
    required String gender,
  }) async {
    if (_isLoading) return false;

    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await _authService.register(
        RegisterRequestModel(
          name: name,
          email: email,
          password: password,
          mobile: mobile,
          gender: gender,
        ),
      );

      _isLoading = false;

      if (response.success) {
        _token = response.token;
        _userName = name;
        _userEmail = email;
        _successMessage = response.message;

        final prefs = await SharedPreferences.getInstance();
        if (_token != null) {
          await prefs.setString(_tokenPrefKey, _token!);
        }
        await prefs.setString(_userNamePrefKey, name);
        await prefs.setString(_userEmailPrefKey, email);

        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        notifyListeners();
        return false;
      }
    } catch (_) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred during registration.';
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userEmail = null;
    _userName = null;
    _errorMessage = null;
    _successMessage = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenPrefKey);
      await prefs.remove(_userEmailPrefKey);
      await prefs.remove(_userNamePrefKey);
    } catch (_) {}

    notifyListeners();
  }

  void clearErrors() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
}
