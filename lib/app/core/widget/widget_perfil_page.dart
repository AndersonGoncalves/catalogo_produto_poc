import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/services/auth/auth_firebase_service.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_text_form_field.dart';

class WidgetPerfilPage extends StatefulWidget {
  const WidgetPerfilPage({super.key});

  @override
  State<WidgetPerfilPage> createState() => _WidgetPerfilPageState();
}

class _WidgetPerfilPageState extends State<WidgetPerfilPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 70,
                        ),
                        child: FittedBox(
                          child: Text(
                            'Perfil',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Nome',
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 16),
                              ),
                              WidgetTextFormField(
                                labelText: '',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                prefixIcon: const Icon(
                                  Icons.account_circle_outlined,
                                ),
                                isDense: true,
                                enabled: false,
                                initialValue:
                                    context
                                        .read<AuthFirebaseService>()
                                        .user
                                        .displayName ??
                                    '',
                                border: true,
                              ),
                              const Text(
                                'Email',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16),
                              ),
                              WidgetTextFormField(
                                labelText: '',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                prefixIcon: const Icon(Icons.email_outlined),
                                isDense: true,
                                enabled: false,
                                initialValue:
                                    context
                                        .read<AuthFirebaseService>()
                                        .user
                                        .email ??
                                    '',
                                border: true,
                              ),
                              const SizedBox(height: 20),

                              ElevatedButton(
                                onPressed: Navigator.of(context).pop,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: Size(double.infinity, 48),
                                  elevation: 0,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text('Ok'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
