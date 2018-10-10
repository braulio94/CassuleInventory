import 'package:flutter/material.dart';
import 'package:inventory_app/database/database.dart';
import 'package:inventory_app/model/product_details.dart';
import 'package:inventory_app/model/product_count.dart';

class ProductDetailPage extends StatefulWidget {

  final ProductDetails detail;
  final ProductDatabase database;

  ProductDetailPage({this.detail, this.database});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetailPage> {

  @override
  initState() {
    super.initState();
    setUpList();
  }

  setUpList() async {
    List<ProductCount> list = await widget.database.getProducts(widget.detail.productName.replaceAll(RegExp(r"\s+\b|\b\s"), ""));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Container(
          width:  screenWidth / 1.2,
          height:  screenHeight / 1.2,
          child: Container(
            height: screenHeight /1.2,
            child: Text(widget.detail.productName, style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
