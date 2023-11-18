import 'dart:io';
import 'dart:async';

import 'package:desafio_flutter_capyba/core/models/user_atributes.dart';
import 'package:desafio_flutter_capyba/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static Map<String, UserAtributes> _users = {};
  static UserAtributes? _currentUser;
  static MultiStreamController<UserAtributes?>? _controller;
  static final _userStream = Stream<UserAtributes?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  Stream<UserAtributes?> get currentUser {
    return _userStream;
  }

  @override
  Stream<UserAtributes?> get userChanges {}

  @override
  Future<void> signup(
      String nome, String email, String password, File image) async {
        
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(UserAtributes? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
