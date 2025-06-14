import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_drawer.dart';
import 'package:catalogo_produto_poc/app/services/auth/auth_firebase_service.dart';

class WidgetErrorPage extends StatelessWidget {
  const WidgetErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        toolbarHeight: 56,
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            'Error',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
      drawer: WidgetDrawer(
        userEmail: context.read<AuthFirebaseService>().user.email,
      ),
      body: SafeArea(
        child: Center(child: Text('Ocorreu um erro na aplicação')),
      ),
    );
  }
}
