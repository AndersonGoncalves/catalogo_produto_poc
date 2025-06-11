import 'package:catalogo_produto_poc/app/core/constants/rotas.dart';
import 'package:flutter/material.dart';

class WidgetDrawer extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  final Widget? userImage;

  const WidgetDrawer({
    this.userName,
    this.userEmail,
    this.userImage,
    super.key,
  });

  @override
  State<WidgetDrawer> createState() => _WidgetDrawerState();
}

class _WidgetDrawerState extends State<WidgetDrawer> {
  Widget _createItem(IconData icon, String label, Function() onTap) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 22, color: Colors.black54),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        ),
      ),
      onTap: onTap,
    );
  }

  Future<void> _sair(BuildContext context) async {
    // context.read<FirebaseAuthService>().signOut(context).then((value) {
    //   if (!context.mounted) return;
    //   Navigator.of(context).pushReplacementNamed(Rotas.authOrHome);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).canvasColor,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: widget.userImage,
            ),
            accountName: Text(
              'Olá, ${widget.userName}',
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              'Seja bem vindo(a)!',
              style: const TextStyle(color: Colors.white),
            ),
          ),

          _createItem(Icons.house_outlined, 'Home', () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(Rotas.home);
          }),
          const Divider(),

          _createItem(Icons.local_offer_outlined, 'Produtos', () {
            Navigator.of(context).popAndPushNamed(Rotas.produtoList);
          }),

          const Divider(),
          _createItem(Icons.account_circle_outlined, 'Perfil', () {
            // if (context.read<FirebaseAuthService>().user.isAnonymous) {
            //   Navigator.of(context).pop();
            //   Navigator.of(context).push(
            //     CupertinoPageRoute(
            //       maintainState: true,
            //       fullscreenDialog: false,
            //       allowSnapshotting: true,
            //       builder: (_) {
            //         return const AuthFormPage(usuarioAnonimo: true);
            //       },
            //     ),
            //   );
            // } else {
            //   Navigator.of(context).popAndPushNamed(Rotas.perfil);
            // }
          }),
          _createItem(Icons.error_outline_outlined, 'Sobre', () {
            // Navigator.of(context).popAndPushNamed(Rotas.about);
          }),
          // _createItem(
          //   Icons.privacy_tip_outlined,
          //   'Política de Privacidade',
          //   () {
          //     Navigator.of(context).pop();
          //     UrlLauncher.openUrl(Url.politicaPrivacidade);
          //   },
          // ),
          // _createItem(
          //   Icons.star,
          //   'Avalie nosso App',
          //   () {
          //     Navigator.of(context).pop();
          //     UrlLauncher.openUrl(Url.myApp);
          //   },
          // ),
          const Divider(),
          _createItem(Icons.exit_to_app_outlined, 'Sair', () {
            // if (context.read<FirebaseAuthService>().user.isAnonymous) {
            //   //Navigator.of(context).pop(); //Não funcionou
            //   AdaptativeDialog(
            //     context,
            //     'Não',
            //     'Sim',
            //   ).confirm(
            //     titulo: 'Atenção',
            //     pergunta:
            //         'Deseja sair da Aplicaçao? Irá perder todos os seus dados.',
            //     onConfirm: () {
            //       _sair(context);
            //     },
            //   );
            // } else {
            //   _sair(context);
            // }
          }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
