import 'package:catalogo_produto_poc/app/core/widget/widget_drawer.dart';
import 'package:flutter/material.dart';

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
        userName: 'Anderson',
        //context.read<FirebaseAuthService>().user.displayName.toString(),
        userEmail: '', // context.read<FirebaseAuthService>().user.email ?? '',
      ),
      body: Container(),
    );
  }
}
