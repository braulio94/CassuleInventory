
import 'package:flutter/material.dart';
import 'package:inventory_app/model/description_details.dart';
import 'package:inventory_app/model/product_count.dart';
import 'package:inventory_app/model/product_details.dart';

List<List<ProductCount>> p = List();

String dateMonth(int monthId) {
  String month;
  switch(monthId){
    case 1:
      month = 'Janeiro';
      break;
    case 2:
      month = 'Fevereiro';
      break;
    case 3:
      month = 'Março';
      break;
    case 4:
      month = 'Abril';
      break;
    case 5:
      month = 'Maio';
      break;
    case 6:
      month = 'Junho';
      break;
    case 7:
      month = 'Julho';
      break;
    case 8:
      month = 'Agosto';
      break;
    case 9:
      month = 'Setembro';
      break;
    case 10:
      month = 'Outubro';
      break;
    case 11:
      month = 'Novembro';
      break;
    case 12:
      month = 'Dezembro';
      break;
  }
  return month;
}

List<ProductDetails> columnList = [
  ProductDetails("DATA", 0.0),
  ProductDetails("DESCRIPTION", 0.0),
  ProductDetails("AGUA NATURAL", 200.0),
  ProductDetails("AGUA FRESCA", 200.0),
  ProductDetails("COCA COLA", 250.0),
  ProductDetails("SUMOL ANANAZ", 250.0),
  ProductDetails("SPRITE", 250.0),
  ProductDetails("FANTA", 250.0),
  ProductDetails("COMPAL", 250.0),
  ProductDetails("SPEED", 300.0),
  ProductDetails("AGUA TONICA", 250.0),
  ProductDetails("GINGER ALE", 250.0),
  ProductDetails("NUTRY", 700.0),
];

List<DescriptionDetail> descriptionIcons = [
  DescriptionDetail(Icons.compare_arrows, 'Diferenca', Colors.orange),
  DescriptionDetail(Icons.remove, 'Falta', Colors.red),
  DescriptionDetail(Icons.add, 'Adicionado', Colors.blue),
  DescriptionDetail(Icons.attach_money, 'Vendido', Colors.green),
  DescriptionDetail(Icons.info_outline, 'Existencia', Colors.black87),
];

