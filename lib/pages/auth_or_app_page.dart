import 'package:desafio_flutter_capyba/core/models/user_atributes.dart';
import 'package:desafio_flutter_capyba/core/services/auth/auth_service.dart';
import 'package:desafio_flutter_capyba/pages/auth_page.dart';
import 'package:desafio_flutter_capyba/pages/home_page.dart';
import 'package:desafio_flutter_capyba/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatefulWidget {
  const AuthOrAppPage({super.key});

  @override
  State<AuthOrAppPage> createState() => _AuthOrAppPageState();
}

class _AuthOrAppPageState extends State<AuthOrAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserAtributes?>(
        stream: AuthService().userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ? const HomePage() : const AuthPage();
          }
        },
      ),
    );
  }
}
