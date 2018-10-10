
import 'package:flutter/material.dart';
import 'package:inventory_app/model/category.dart';
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
  ProductDetails("AGUA NATURAL", 200.0, assetPath: 'assets/images/agua_pura.jpg'),
  ProductDetails("AGUA FRESCA", 200.0, assetPath: 'assets/images/agua_pura.jpg'),
  ProductDetails("COCA COLA", 250.0),
  ProductDetails("SUMOL ANANAZ", 250.0),
  ProductDetails("SPRITE", 250.0),
  ProductDetails("FANTA", 250.0, assetPath: 'assets/images/fanta_lata.png'),
  ProductDetails("COMPAL", 250.0),
  ProductDetails("SPEED", 300.0),
  ProductDetails("AGUA TONICA", 250.0),
  ProductDetails("GINGER ALE", 250.0),
  ProductDetails("BLUE GINGIBRE", 250.0),
  ProductDetails("NUTRY", 700.0),
];


List<ProductDetails> beerList = [
  ProductDetails("DATA1", 0.0),
  ProductDetails("DESCRIPTION1", 0.0),
  ProductDetails("CUCA PRETA", 250.0, assetPath: 'assets/images/cuca_preta_lata.png'),
  ProductDetails("CUCA LATA", 250.0, assetPath: 'assets/images/cuca_lata.png'),
  ProductDetails("CUCA GARRAFA", 200.0, assetPath: 'assets/images/cuca_garrafa.png'),
  ProductDetails("NOCAL GARRAFA", 200.0, assetPath: 'assets/images/nocal_garrafa.png'),
  ProductDetails("NOCAL LATA", 250.0, assetPath: 'assets/images/nocal_lata.png'),
  ProductDetails("EKA GARRAFA", 200.0, assetPath: 'assets/images/eka_garrafa.png'),
  ProductDetails("EKA LATA", 200.0, assetPath: 'assets/images/eka_lata.png'),
  ProductDetails("SMINORFF", 500.0),
  ProductDetails("DOPEL", 300.0),
  ProductDetails("BOOSTER GARRAFA", 250.0, assetPath: 'assets/images/booster_garrafa.jpg'),
  ProductDetails("BOOSTER LATA", 250.0, assetPath: 'assets/images/booster_lata.jpg'),
  ProductDetails("VT COPO", 500.0, assetPath: 'assets/images/vinho_copo.jpg'),
];

List<ProductDetails> foodList = [
  ProductDetails("DATA2", 0.0),
  ProductDetails("DESCRIPTION2", 0.0),
  ProductDetails("HAMBURGUER", 80.0, assetPath: 'assets/images/hamburger.jpg'),
  ProductDetails("PAO HAMBURGUER", 40.0, assetPath: 'assets/images/hamburger.jpg'),
  ProductDetails("MASSA PIZZA", 1000.0),
  ProductDetails("CAIXA PIZZA", 300.0),
  ProductDetails("TIGELA TW GRANDE", 150.0),
  ProductDetails("TIGELA TW PEQUENA", 150.0),
  ProductDetails("BIFE CARNE", 380.0, assetPath: 'assets/images/carne.png'),
  ProductDetails("BIFE ISCA", 150.0, assetPath: 'assets/images/isca.png'),
  ProductDetails("BIFE FRANGO", 300.0, assetPath: 'assets/images/frango.png'),
  ProductDetails("FEBRAS", 400.0),
  ProductDetails("OVOS", 45.0),
  ProductDetails("PICANHA", 600.0),
];

List<ProductDetails> otherList = [
  ProductDetails("DATA3", 0.0),
  ProductDetails("DESCRIPTION3", 0.0),
  ProductDetails("SOPA", 700.0),
];

List<Category> allCategories = <Category>[
  Category(
    title: 'REFRIGEIRANTES & AGUA',
    list: softDrinkList,
  ),
  Category(
    title: 'CERVEJAS',
    list: beerList,
  ),
  Category(
    title: 'COMIDA',
    list: foodList,
  ),
  Category(
    title: 'OUTROS',
    list: otherList,
  ),
];


List<DescriptionDetail> descriptionIcons = [
  DescriptionDetail(Icons.compare_arrows, 'Diferenca', Colors.orange),
  DescriptionDetail(Icons.remove, 'Falta', Colors.red),
  DescriptionDetail(Icons.add, 'Adicionado', Colors.blue),
  DescriptionDetail(Icons.attach_money, 'Vendido', Colors.green),
  DescriptionDetail(Icons.info_outline, 'Existencia', Colors.black87),
];

