
import 'package:flutter/material.dart';
import 'package:inventory_app/model/description_details.dart';
import 'package:inventory_app/model/product_details.dart';

List<ProductDetails> columnList = [
  ProductDetails("DATA", 0.0),
  ProductDetails("DESCRIPTION", 0.0),
  ProductDetails("COCA COLA", 250.0),
  ProductDetails("CUCA LATA", 250.0),
  ProductDetails("EKA GARRAFA", 250.0),
  ProductDetails("SMINORFF", 500.0),
];

List<DescriptionDetail> descriptionIcons = [
  DescriptionDetail(Icons.compare_arrows, 'Diferenca', Colors.orange),
  DescriptionDetail(Icons.remove, 'Falta', Colors.red),
  DescriptionDetail(Icons.add, 'Adicionado', Colors.blue),
  DescriptionDetail(Icons.attach_money, 'Vendido', Colors.green),
  DescriptionDetail(Icons.info_outline, 'Resto', Colors.black87),
];

