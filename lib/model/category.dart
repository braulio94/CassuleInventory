import 'package:inventory_app/model/product_details.dart';

class Category {
  const Category({ this.title, this.list});
  final String title;
  final List<ProductDetails> list;
  @override
  String toString() => '$runtimeType("$title")';
}