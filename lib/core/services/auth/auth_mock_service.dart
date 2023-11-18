import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:desafio_flutter_capyba/core/models/user_atributes.dart';
import 'package:desafio_flutter_capyba/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static const _defaultUser = UserAtributes(
    id: '1',
    name: 'Teste',
    email: 'Teste@gmail.com',
    imageURL: 'assets/images/avatar.png',
  );

  static final Map<String, UserAtributes> _users = {
    _defaultUser.email: _defaultUser,
  };
  static UserAtributes? _currentUser;
  static MultiStreamController<UserAtributes?>? _controller;
  static final _userStream = Stream<UserAtributes?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  @override
  UserAtributes? get currentUser {
    return _currentUser;
  }

  @override
  Stream<UserAtributes?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = UserAtributes(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageURL: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
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
