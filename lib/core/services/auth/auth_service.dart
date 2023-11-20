import 'dart:io';
import 'package:desafio_flutter_capyba/core/models/user_atributes.dart';
import 'package:desafio_flutter_capyba/core/services/auth/auth_mock_service.dart';

abstract class AuthService {
  UserAtributes? get currentUser;

  Stream<UserAtributes?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();

  factory AuthService() {
    return AuthMockService();
    //return AuthFirebaseService();
  }
}
