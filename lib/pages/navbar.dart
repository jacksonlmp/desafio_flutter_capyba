import 'package:desafio_flutter_capyba/core/models/auth_form_data.dart';
import 'package:desafio_flutter_capyba/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(AuthFormData().name),
            accountEmail: Text(AuthFormData().email),
            decoration: const BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                image: NetworkImage(
                  'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: Text('Meu perfil'),
          ),
          const ListTile(
            leading: Icon(Icons.email),
            title: Text('Verificação de e-mail'),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Sair da conta'),
            onTap: () => AuthService().logout(),
          ),
        ],
      ),
    );
  }
}
