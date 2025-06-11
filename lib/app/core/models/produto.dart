import 'dart:convert';
import 'package:flutter/foundation.dart';

class Produto with ChangeNotifier {
  final String id;
  final DateTime dataCadastro;
  final String nome;
  final String descricao;
  final String marca;
  final double precoDeCusto;
  final double precoDeVenda;
  final List<String>? fotos;
  Produto({
    required this.id,
    required this.dataCadastro,
    required this.nome,
    required this.descricao,
    required this.marca,
    required this.precoDeCusto,
    required this.precoDeVenda,
    this.fotos,
  });

  Produto copyWith({
    String? id,
    DateTime? dataCadastro,
    String? nome,
    String? descricao,
    String? marca,
    double? precoDeCusto,
    double? precoDeVenda,
    ValueGetter<List<String>?>? fotos,
  }) {
    return Produto(
      id: id ?? this.id,
      dataCadastro: dataCadastro ?? this.dataCadastro,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      marca: marca ?? this.marca,
      precoDeCusto: precoDeCusto ?? this.precoDeCusto,
      precoDeVenda: precoDeVenda ?? this.precoDeVenda,
      fotos: fotos != null ? fotos() : this.fotos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataCadastro': dataCadastro.millisecondsSinceEpoch,
      'nome': nome,
      'descricao': descricao,
      'marca': marca,
      'precoDeCusto': precoDeCusto,
      'precoDeVenda': precoDeVenda,
      'fotos': fotos,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'] ?? '',
      dataCadastro: DateTime.fromMillisecondsSinceEpoch(map['dataCadastro']),
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      marca: map['marca'] ?? '',
      precoDeCusto: map['precoDeCusto']?.toDouble() ?? 0.0,
      precoDeVenda: map['precoDeVenda']?.toDouble() ?? 0.0,
      fotos: List<String>.from(map['fotos']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) =>
      Produto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Produto(id: $id, dataCadastro: $dataCadastro, nome: $nome, descricao: $descricao, marca: $marca, precoDeCusto: $precoDeCusto, precoDeVenda: $precoDeVenda, fotos: $fotos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Produto &&
        other.id == id &&
        other.dataCadastro == dataCadastro &&
        other.nome == nome &&
        other.descricao == descricao &&
        other.marca == marca &&
        other.precoDeCusto == precoDeCusto &&
        other.precoDeVenda == precoDeVenda &&
        listEquals(other.fotos, fotos);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dataCadastro.hashCode ^
        nome.hashCode ^
        descricao.hashCode ^
        marca.hashCode ^
        precoDeCusto.hashCode ^
        precoDeVenda.hashCode ^
        fotos.hashCode;
  }
}
