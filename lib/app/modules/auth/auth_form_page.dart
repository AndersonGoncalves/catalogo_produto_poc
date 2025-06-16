import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/services/auth/auth_firebase_service.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_loading_page.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_text_form_field.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_text_button.dart';

enum AuthMode { signup, login }

class AuthFormPage extends StatefulWidget {
  final bool usuarioAnonimo;

  const AuthFormPage({this.usuarioAnonimo = false, super.key});

  @override
  State<AuthFormPage> createState() => _AuthFormPageState();
}

class _AuthFormPageState extends State<AuthFormPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  AuthMode? _authMode;
  final Map<String, String> _formData = {'email': '', 'password': ''};

  AnimationController? _controller;

  bool get _isLogin => _authMode == AuthMode.login;

  @override
  void initState() {
    super.initState();

    if (widget.usuarioAnonimo) {
      _authMode = AuthMode.signup;
    } else {
      _authMode = AuthMode.login;
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin) {
        _authMode = AuthMode.signup;
        _controller?.forward();
      } else {
        _authMode = AuthMode.login;
        _controller?.reverse();
      }
    });
  }

  Future<void> _loginAnonimo() async {
    setState(() => _isLoading = true);

    try {
      if (widget.usuarioAnonimo) {
        Navigator.of(context).pop();
      } else {
        AuthFirebaseService firebaseAuthService = context
            .read<AuthFirebaseService>();
        await firebaseAuthService.signInAnonymously(context);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    AuthFirebaseService firebaseAuthService = context
        .read<AuthFirebaseService>();

    try {
      if (_isLogin) {
        await firebaseAuthService.loginWithEmail(
          email: _formData['email']!,
          password: _formData['password']!,
          context: context,
        );
      } else {
        if (widget.usuarioAnonimo) {
          await firebaseAuthService
              .converterContaAnonimaEmPermanente(
                name: _formData['name']!,
                email: _formData['email']!,
                password: _formData['password']!,
                context: context,
              )
              .then((value) {
                if (widget.usuarioAnonimo) {
                  if (!mounted) return;
                  Navigator.of(context).pop();
                }
              });
        } else {
          await firebaseAuthService.signUpWithEmail(
            name: _formData['name']!,
            email: _formData['email']!,
            password: _formData['password']!,
            context: context,
          );
        }
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? WidgetLoadingPage(label: 'Carregando...', labelColor: Colors.white)
          : SafeArea(
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
                                  'PoC',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 5,
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Text(
                                            _isLogin
                                                ? 'Informe um email e uma senha de 6 dígitos e tenha acesso ao App'
                                                : 'Informe um email e uma senha de 6 dígitos e registre-se no App',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        _isLogin
                                            ? const SizedBox()
                                            : WidgetTextFormField(
                                                labelText: 'Nome',
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                textInputAction:
                                                    TextInputAction.next,
                                                prefixIcon: const Icon(
                                                  Icons.account_circle_outlined,
                                                ),
                                                isDense: true,
                                                border: true,
                                                onSaved: (value) =>
                                                    _formData['name'] =
                                                        value ?? '',
                                              ),

                                        WidgetTextFormField(
                                          labelText: 'Email',
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          prefixIcon: const Icon(
                                            Icons.email_outlined,
                                          ),
                                          isDense: true,
                                          border: true,
                                          onSaved: (value) =>
                                              _formData['email'] = value ?? '',
                                        ),
                                        WidgetTextFormField(
                                          labelText: 'Senha',
                                          prefixIcon: const Icon(
                                            Icons.lock_outline,
                                          ),
                                          isDense: true,
                                          border: true,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          controller: _passwordController,
                                          obscureText: true,
                                          validator: (value) {
                                            final password = value ?? '';
                                            if (password.isEmpty ||
                                                password.length < 5) {
                                              return 'Informe uma senha válida';
                                            }
                                            return null;
                                          },
                                          onSaved: (password) =>
                                              _formData['password'] =
                                                  password ?? '',
                                        ),

                                        _isLogin
                                            ? const SizedBox()
                                            : WidgetTextFormField(
                                                labelText: 'Confirmar Senha',
                                                prefixIcon: const Icon(
                                                  Icons.lock_outline,
                                                ),
                                                isDense: true,
                                                border: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscureText: true,
                                                validator: _isLogin
                                                    ? null
                                                    : (value) {
                                                        final password =
                                                            value ?? '';
                                                        if (password !=
                                                            _passwordController
                                                                .text) {
                                                          return 'Senhas informadas não conferem';
                                                        }
                                                        return null;
                                                      },
                                              ),
                                        _isLogin
                                            ? const SizedBox()
                                            : Column(
                                                children: [
                                                  Text(
                                                    'Ao usar o app, você concorda com nossos',
                                                    style: const TextStyle(
                                                      fontSize: 9,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      'Termos de Uso & Política de Privacidade',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        const SizedBox(height: 20),
                                        if (_isLoading)
                                          const CircularProgressIndicator()
                                        else
                                          ElevatedButton(
                                            onPressed: _save,
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              minimumSize: Size(
                                                double.infinity,
                                                48,
                                              ),
                                              elevation: 0,
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: Text(
                                              _authMode == AuthMode.login
                                                  ? 'ENTRAR'
                                                  : 'REGISTRAR',
                                            ),
                                          ),
                                        widget.usuarioAnonimo
                                            ? const SizedBox()
                                            : WidgetTextButton(
                                                _isLogin
                                                    ? 'DESEJA REGISTRAR?'
                                                    : 'JÁ POSSUI CONTA?',
                                                onPressed: _switchAuthMode,
                                              ),
                                        WidgetTextButton(
                                          'NÃO QUERO ME REGISTRAR!',
                                          foregroundColor: Colors.red,
                                          onPressed: _loginAnonimo,
                                        ),
                                      ],
                                    ),
                                  ),
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
