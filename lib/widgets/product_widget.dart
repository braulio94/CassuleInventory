import 'package:flutter/material.dart';
import 'package:inventory_app/data.dart';
import 'package:inventory_app/model/edit_product.dart';
import 'package:inventory_app/model/product_count.dart';
import 'package:inventory_app/database/database.dart';
import 'product_row.dart';

class ProductCountWidget extends StatefulWidget {

  final ProductCount productCount;
  final ProductDatabase database;
  final Function(ProductCount selectedProduct, ProductEdit state) onSelectedProduct;

  ProductCountWidget({this.productCount, this.database, this.onSelectedProduct});

  @override
  _ProductCountWidgetState createState() => _ProductCountWidgetState();
}

class _ProductCountWidgetState extends State<ProductCountWidget> {

  void changeProductValue(ProductEdit editState){
    widget.onSelectedProduct(widget.productCount, editState);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 8.0),
      elevation: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ProductRowValue(
            value: '${widget.productCount.diff}',
            holderName: ProductEdit.Diff,
            product: widget.productCount,
            onPressed: (){
              changeProductValue(ProductEdit.Diff);
            },
          ),
          ProductRowValue(
            value: '${widget.productCount.missing}',
            holderName: ProductEdit.Missing,
            product: widget.productCount,
            style: TextStyle(color: widget.productCount.missing.isNegative ? Colors.red : Colors.black, fontWeight: widget.productCount.missing.isNegative ? FontWeight.w900 : FontWeight.normal),
            onPressed: (){
              changeProductValue(ProductEdit.Missing);
            },
          ),
          ProductRowValue(
            value: '${widget.productCount.added}',
            holderName: ProductEdit.Added,
            product: widget.productCount,
            onPressed: (){
              changeProductValue(ProductEdit.Added);
            },
          ),
          ProductRowValue(
            value: '${widget.productCount.sold}',
            holderName: ProductEdit.Sold,
            product: widget.productCount,
            onPressed: (){
              changeProductValue(ProductEdit.Sold);
            },
          ),
          ProductRowValue(
            value: '${widget.productCount.remaining}',
            holderName: ProductEdit.Remaining,
            product: widget.productCount,
            onPressed: (){
              changeProductValue(ProductEdit.Remaining);
            },
          ),
        ],
      ),
    );
  }
}
