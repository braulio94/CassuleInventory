import 'package:flutter/material.dart';
import 'package:inventory_app/data.dart';
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
  var selectedProductEdit;
  bool enabled = false;

  changeEnabledState(){
    setState(() {
      enabled = !enabled;
      print('Changed enabled value to $enabled');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double rowCountWidth = 80.0;
    return GestureDetector(
      onTap: (){
        selectedProductEdit = widget.holderName;
        if (widget.product.today && selectedProductEdit != ProductEdit.Diff  && selectedProductEdit != ProductEdit.Missing){
          changeEnabledState();
          print('Product  edit ${widget.product.id} ${widget.holderName}');
        }
      },
      //onDoubleTap: widget.onPressed,
      child: Container(
        height: 50.0,
        width: rowCountWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black12),
          color: widget.product.today && enabled? Colors.red[800] : null,
        ),
        child: Text(
          widget.value,
          textAlign: TextAlign.center,
          style: widget.style  != null ? widget.style : TextStyle(color: widget.product.today && enabled? Colors.white : Colors.black) ,
        ),
      ),
    );
  }
}