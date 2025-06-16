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
  int _selectedPageIndex = 0;

  _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> pages = [
      {'title': 'Page1', 'page': const SizedBox()},
      {'title': 'Page2', 'page': const SizedBox()},
      {'title': 'Page3', 'page': const SizedBox()},
      {'title': 'Page4', 'page': const SizedBox()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('PoC')),
      drawer: WidgetDrawer(
        userName: context
            .read<AuthFirebaseService>()
            .user
            .displayName
            .toString(),
        userEmail: context.read<AuthFirebaseService>().user.email ?? '',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: pages[_selectedPageIndex]['page'] as Widget),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 58,
        child: Column(
          children: [
            BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              currentIndex: _selectedPageIndex,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.assessment_outlined),
                  label: '',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.supervisor_account_sharp),
                  label: '',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.account_balance_sharp),
                  label: '',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.credit_card),
                  label: '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
