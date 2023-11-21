import 'dart:io';
import 'dart:async';
import 'package:desafio_flutter_capyba/core/models/user_atributes.dart';
import 'package:desafio_flutter_capyba/core/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {
  static UserAtributes? _currentUser;

  static final _userStream = Stream<UserAtributes?>.multi(
    (controller) async {
      final authChanges = FirebaseAuth.instance.authStateChanges();
      await for (final user in authChanges) {
        _currentUser = user == null ? null : _toUserAtributes(user);
        controller.add(_currentUser);
      }
    },
  );

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
    try {
      final auth = FirebaseAuth.instance;
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) return;

      //Upload foto usuario
      final imageName = '${credential.user!.uid}.jpg';
      final imageURL = await _uploadUserImage(image, imageName);

      //Atualiza atributos do usuário
      await credential.user?.updateDisplayName(name);
      await credential.user?.updatePhotoURL(imageURL);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image);
    return await imageRef.getDownloadURL();
  }

  static UserAtributes _toUserAtributes(User user) {
    return UserAtributes(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
