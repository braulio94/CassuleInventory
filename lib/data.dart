
import 'package:inventory_app/model/product_count.dart';
import 'package:intl/intl.dart';

List<List<ProductCount>> p = [
  productList,
];

List<ProductCount> productList = [
  ProductCount('DATA', DateFormat.yMMMd().format(DateTime.now()), 0, 0, 0, 0, 0, 0, 0, false, true),
  ProductCount('COCA COLA', DateTime.now().toString(), 0, 0, 0, 0, 0, 0, 0, false, true),
  ProductCount('CUCA LATA', DateTime.now().toString(), 0, 0, 0, 0, 0, 0, 0, false, true),
  ProductCount('EKA GARRAFA', DateTime.now().toString(), 0, 0, 0, 0, 0, 0, 0, false, true),
];

List<String> columnList = [
  'DATA',
  'COCA COLA',
  'CUCA LATA',
  'EKA GARRAFA',
];

