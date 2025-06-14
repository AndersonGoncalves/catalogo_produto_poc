import 'dart:convert';
import 'package:flutter/foundation.dart';

class Produto with ChangeNotifier {
  final String id;
  final DateTime dataCadastro;
  final String nome;
  final String? descricao;
  final String? marca;
  final double precoDeCusto;
  final double precoDeVenda;
  final List<String>? fotos;

  Produto({
    required this.id,
    required this.dataCadastro,
    required this.nome,
    this.descricao,
    this.marca,
    this.precoDeCusto = 0.00,
    this.precoDeVenda = 0.00,
    this.fotos = const [],
  });

  Produto copyWith({
    String? id,
    DateTime? dataCadastro,
    String? nome,
    ValueGetter<String?>? descricao,
    ValueGetter<String?>? marca,
    double? precoDeCusto,
    double? precoDeVenda,
    ValueGetter<List<String>?>? fotos,
  }) {
    return Produto(
      id: id ?? this.id,
      dataCadastro: dataCadastro ?? this.dataCadastro,
      nome: nome ?? this.nome,
      descricao: descricao != null ? descricao() : this.descricao,
      marca: marca != null ? marca() : this.marca,
      precoDeCusto: precoDeCusto ?? this.precoDeCusto,
      precoDeVenda: precoDeVenda ?? this.precoDeVenda,
      fotos: fotos != null ? fotos() : this.fotos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataCadastro': dataCadastro.toIso8601String(),
      'nome': nome,
      'descricao': descricao,
      'marca': marca,
      'precoDeCusto': precoDeCusto,
      'precoDeVenda': precoDeVenda,
      'fotos': fotos,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map, bool load) {
    return Produto(
      id: map['id'] as String,
      dataCadastro: map['id'] == ''
          ? DateTime.now()
          : DateTime.tryParse(map['dataCadastro'].toString())!,
      nome: map['nome'].toString(),
      descricao: map['descricao']?.toString(),
      marca: map['marca']?.toString(),
      precoDeVenda: load
          ? map['precoDeVenda']?.toDouble() ?? 0.0
          : double.tryParse(
                  map['precoDeVenda']
                      .replaceAll(RegExp(r'[^0-9]'), '')
                      .toString(),
                )! /
                100,
      precoDeCusto: load
          ? map['precoDeCusto']?.toDouble() ?? 0.0
          : double.tryParse(
                  map['precoDeCusto']
                      .replaceAll(RegExp(r'[^0-9]'), '')
                      .toString(),
                )! /
                100,
      fotos: map['fotos'] != null
          ? load
                ? (map['fotos'] as List<dynamic>).map((item) {
                    return item['url'].toString();
                  }).toList()
                : (map['fotos'] as List<String>).map((item) {
                    return item.toString();
                  }).toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) =>
      Produto.fromMap(json.decode(source), true);

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
