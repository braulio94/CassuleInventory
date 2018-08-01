
import 'package:flutter/material.dart';
import 'package:inventory_app/model/description_details.dart';
import 'package:inventory_app/model/product_count.dart';
import 'package:inventory_app/model/product_details.dart';

List<List<ProductCount>> p = List();

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

