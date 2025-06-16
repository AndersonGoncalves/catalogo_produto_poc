import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String onlyNumber(String value) {
  return value.replaceAll(RegExp(r'[^0-9]'), '');
}

double precoVenda(double custo, double percentualLucro) {
  return (custo * (percentualLucro / 100)) + custo;
}

double percentualMarkup(double custo, double precoVenda) {
  if (custo == 0) {
    return 0;
  } else {
    return ((precoVenda - custo) / custo) * 100;
  }
}

double percentualLucroMarkup(double custo, double precoVenda) {
  if (precoVenda == 0) {
    return 0;
  } else {
    return ((precoVenda - custo) / precoVenda) * 100;
  }
}

double lucro(double custo, double precoVenda) {
  return precoVenda - custo;
}

String getData(BuildContext context, DateTime data) {
  final DateTime now = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  final DateTime date = DateTime(data.year, data.month, data.day);

  if (date.add(const Duration(days: 1)) == now) {
    return 'ontem';
  } else if (date == now) {
    return 'Hoje';
  } else if (date.subtract(const Duration(days: 1)) == now) {
    return 'Amanhã';
  } else {
    return DateFormat('dd/MM/y').format(date);
  }
}

void showSnackBar(
  BuildContext context,
  String text, [
  Color backgroundColor = Colors.black,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: backgroundColor, content: Text(text)),
  );
}
