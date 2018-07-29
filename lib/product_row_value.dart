import 'package:flutter/material.dart';
import 'package:inventory_app/model/edit_product.dart';
import 'package:inventory_app/model/product_count.dart';

class ProductRowValue extends StatefulWidget {

  final ProductCount product;
  final ProductEdit holderName;
  final String value;
  final TextStyle style;
  final VoidCallback onPressed;

  ProductRowValue({this.product, this.holderName, this.value, this.style, this.onPressed});

  @override
  ProductRowValueState createState() => ProductRowValueState();
}

class ProductRowValueState extends State<ProductRowValue> {

  @override
  Widget build(BuildContext context) {
    final double rowCountWidth = 80.0;
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 50.0,
        width: rowCountWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black12),
          color: widget.product.editDiff && widget.product.edit == widget.holderName ? Colors.red[700] : null,
        ),
        child: Text(
          widget.value,
          textAlign: TextAlign.center,
          style: widget.style  != null ? widget.style : TextStyle(color: widget.product.editDiff && widget.product.edit == widget.holderName ? Colors.white : Colors.black) ,
        ),
      ),
    );
  }
}