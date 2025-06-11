class Url {
  static const String _firebaseUrl =
      'https://rotas-sz-default-rtdb.firebaseio.com';

  Url.firebase();

  String get produto => '$_firebaseUrl/produto';
}
