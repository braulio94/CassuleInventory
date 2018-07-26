
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
  DescriptionDetail(Icons.compare_arrows, 'Diferenca'),
  DescriptionDetail(Icons.remove, 'Falta'),
  DescriptionDetail(Icons.add, 'Adicionado'),
  DescriptionDetail(Icons.attach_money, 'Vendido'),
  DescriptionDetail(Icons.info_outline, 'Resto'),
];

