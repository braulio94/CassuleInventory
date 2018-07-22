
import 'package:inventory_app/model/product_count.dart';

List<ProductCount> cokeCountList = [
  ProductCount('COCA COLA', DateTime.now().toString(), 0, 0, 0, 0, 0, false, true)
];

List<ProductCount> cucaCountList = [
  ProductCount('CUCA LATA', DateTime.now().toString(), 0, 0, 0, 0, 0, false, true)
];

List<ProductCount> ekaCountList = [
  ProductCount('EKA GARRAFA', DateTime.now().toString(), 0, 0, 0, 0, 0, false, true)
];

List<ProductCount> dateCountList = [
  ProductCount('DATA', DateTime.now().toString(), 0, 0, 0, 0, 0, false, true)
];

List<List<ProductCount>> p = [
  cokeCountList,
  cucaCountList,
  ekaCountList,
  dateCountList,
];

List<String> columnList = [
  'DATA',
  'COCA COLA',
  'CUCA LATA',
  'EKA GARRAFA',
];

