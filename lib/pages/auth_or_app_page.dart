import 'package:desafio_flutter_capyba/core/models/user_atributes.dart';
import 'package:desafio_flutter_capyba/core/services/auth/auth_service.dart';
import 'package:desafio_flutter_capyba/pages/auth_page.dart';
import 'package:desafio_flutter_capyba/pages/home_page.dart';
import 'package:desafio_flutter_capyba/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return StreamBuilder<UserAtributes?>(
            stream: AuthService().userChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              } else {
                return snapshot.hasData ? const HomePage() : const AuthPage();
              }
            },
          );
        }
      },
    );
  }
}
