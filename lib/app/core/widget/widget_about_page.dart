import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class WidgetAboutPage extends StatefulWidget {
  const WidgetAboutPage({super.key});

  @override
  State<WidgetAboutPage> createState() => _WidgetAboutPageState();
}

class _WidgetAboutPageState extends State<WidgetAboutPage> {
  String _version = '';

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 56,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.close),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text('Sobre'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/icon/icon-splash.png'),
              ),
              Text(
                'PoC',
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(height: 50),
              Text(
                'Versão $_version',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                'Desenvolvido por Anderson Gonçalves',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
