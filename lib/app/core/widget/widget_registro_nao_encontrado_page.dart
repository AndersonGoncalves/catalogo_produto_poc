import 'package:flutter/material.dart';

class WidgetRegistroNaoEncontradoPage extends StatelessWidget {
  const WidgetRegistroNaoEncontradoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 250, //MediaQuery.of(context).size.height - 350,
        child: Center(
          child: Text(
            'Registro não encontrado',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
