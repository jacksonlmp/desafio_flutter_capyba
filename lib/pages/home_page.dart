import 'package:flutter/material.dart';
import 'package:desafio_flutter_capyba/pages/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Desafio Capyba',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: const NavBar(),
      body: const Center(
        child: Text('Conteúdo da Homepage'),
      ),
    );
  }
}
