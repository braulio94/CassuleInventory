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
    List<int> missingList = [];
    List<int> soldList = [];
    List<int> addedList = [];
    list.forEach((product){
      print('Added missing: ${product.missing}');
      missingList.add(product.missing);
    });
    var sum = missingList.reduce((a, b) => a + b);
    print('Total missing: $sum');
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 32.0),
              alignment: Alignment.topCenter,
              width: screenWidth / 3,
              height: screenHeight / 1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(widget.detail.productName, style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                  Image.asset(widget.detail.assetPath != null ? widget.detail.assetPath : null, height: screenHeight / 1.5),
                ],
              ),
            ),
            Container(
              width: screenWidth / 2,
              height: screenHeight / 1.2,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
