import 'package:flutter/material.dart';

class WidgetAboutPage extends StatefulWidget {
  const WidgetAboutPage({super.key});

  @override
  State<WidgetAboutPage> createState() => _WidgetAboutPageState();
}

class _WidgetAboutPageState extends State<WidgetAboutPage> {
  // String _appName = '';
  // String _packageName = '';
  String _version = '';
  // String _buildNumber = '';

  Future<void> _initPackageInfo() async {
    // final info = await PackageInfo.fromPlatform();
    setState(() {
      // _appName = info.appName;
      // _packageName = info.packageName;
      // _version = info.version;
      // _buildNumber = info.buildNumber;
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 56,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
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
                'Catálogo de Produtos',
                style: const TextStyle(fontSize: 34, color: Colors.white),
              ),
              const SizedBox(height: 50),
              Text(
                'Versão',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                'Anderson Gonçalves',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
