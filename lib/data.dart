
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

List<ProductDetails> softDrinkList = [
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


List<ProductDetails> beerList = [
  ProductDetails("DATA", 0.0),
  ProductDetails("DESCRIPTION", 0.0),
  ProductDetails("CUCA PRETA", 250.0),
  ProductDetails("CUCA LATA", 250.0),
  ProductDetails("CUCA GARRAFA", 200.0),
  ProductDetails("NOCAL GARRAFA", 200.0),
  ProductDetails("NOCAL LATA", 250.0),
  ProductDetails("EKA GARRAFA", 200.0),
  ProductDetails("EKA LATA", 200.0),
  ProductDetails("SMINORFF", 500.0),
  ProductDetails("DOPEL", 300.0),
  ProductDetails("BOOSTER GARRAFA", 250.0),
  ProductDetails("BOOSTER LATA", 250.0),
  ProductDetails("VT COPO", 500.0),
];

List<ProductDetails> foodList = [
  ProductDetails("DATA", 0.0),
  ProductDetails("DESCRIPTION", 0.0),
  ProductDetails("HAMBURGUER", 80.0),
  ProductDetails("PAO HAMBURGUER", 40.0),
  ProductDetails("MASSA PIZZA", 1000.0),
  ProductDetails("CAIXA PIZZA", 300.0),
  ProductDetails("TIGELA TW GRANDE", 150.0),
  ProductDetails("TIGELA TW PEQUENA", 150.0),
  ProductDetails("BIFE CARNE", 380.0),
  ProductDetails("BIFE ISCA", 150.0),
  ProductDetails("BIFE FRANGO", 300.0),
  ProductDetails("FEBRAS", 400.0),
  ProductDetails("OVOS", 45.0),
  ProductDetails("PICANHA", 600.0),
];


List<DescriptionDetail> descriptionIcons = [
  DescriptionDetail(Icons.compare_arrows, 'Diferenca', Colors.orange),
  DescriptionDetail(Icons.remove, 'Falta', Colors.red),
  DescriptionDetail(Icons.add, 'Adicionado', Colors.blue),
  DescriptionDetail(Icons.attach_money, 'Vendido', Colors.green),
  DescriptionDetail(Icons.info_outline, 'Existencia', Colors.black87),
];

