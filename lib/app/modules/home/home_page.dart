import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_drawer.dart';
import 'package:catalogo_produto_poc/app/services/auth/auth_firebase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      drawer: WidgetDrawer(
        userName: context
            .read<AuthFirebaseService>()
            .user
            .displayName
            .toString(),
        userEmail: context.read<AuthFirebaseService>().user.email ?? '',
      ),
      body: Container(),
    );
  }
}
