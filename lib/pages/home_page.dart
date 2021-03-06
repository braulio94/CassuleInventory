import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/pages/product_detail_page.dart';
import 'package:inventory_app/widgets/calc_buttons.dart';
import 'package:inventory_app/calculations.dart';
import 'package:inventory_app/database/data.dart';
import 'package:inventory_app/model/description_details.dart';
import 'package:inventory_app/model/edit_product.dart';
import 'package:inventory_app/model/product_count.dart';
import 'dart:core';
import 'package:flutter/scheduler.dart';
import 'package:inventory_app/model/product_details.dart';
import 'package:inventory_app/widgets/product_widget.dart';
import 'package:inventory_app/database/database.dart';


class HomePage extends StatefulWidget {

  final ProductDatabase database;
  final List<ProductDetails> productDetailsList;
  final int selectedMonth;

  HomePage({Key key, this.database, this.productDetailsList, this.selectedMonth}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ScrollController _scrollController = new ScrollController();
  ProductCount selectedProduct;

  @override
  initState() {
    super.initState();
    setUpList();
  }

  setUpList() async {
    setState(() {
      p.clear();
    });
    List<ProductCount> list = await widget.database.getProducts(widget.productDetailsList[1].productName.replaceAll(RegExp(r"\s+\b|\b\s"), ""));
    for(ProductCount count in list){
      List<ProductCount> countList = [];
      for(int i = 0; i < widget.productDetailsList.length; i++){
        String tableName = widget.productDetailsList[i].productName.replaceAll(RegExp(r"\s+\b|\b\s"), "");
        ProductCount product =  await widget.database.getSingleProduct(count.id, tableName);
        if(product.date.date.month == widget.selectedMonth){
          countList.add(product);
        }
      }
      setState(() {
        if(countList.isNotEmpty){
          p.add(countList);
        }
      });
    }
  }


  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setUpList();
  }

  void _addNewProduct() async {
    List<ProductCount> list = [];
    int dateId = await widget.database.upsertInventoryDate();
    for(int i = 0; i< widget.productDetailsList.length; i++){
      String productName = widget.productDetailsList[i].productName.replaceAll(RegExp(r"\s+\b|\b\s"), "");
      if(p.isNotEmpty){
        p.last[i].today = false;
      }
      ProductCount product = ProductCount(productName, p.isNotEmpty ? p.last[i].remaining : 0, p.isNotEmpty ? p.last[i].added : 0, 0, 0, 0, 0, 0, false, true, dateId: dateId);
      product = await widget.database.upsertProduct(product, productName);
      list.add(product);
      if(p.isNotEmpty){
        widget.database.upsertProduct(p.last[i], productName);
      }
    }
    setState(() {
      p.add(list);
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double screenWidth = MediaQuery.of(context).size.width;
    double tableWidth = 3 * (screenWidth / 4);
    double keyboardWidth = screenWidth / 4;
    return Scaffold(
      body: Container(
        color: Colors.black87,
        //padding: EdgeInsets.only(top: (statusBarHeight * 2)),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: CalculatorButtons(
                keyboardWidth: keyboardWidth,
                onNumberPressed: (int value){
                  print('Number pressed is $value');
                  if(selectedProduct != null && selectedProduct.today){
                    setState(() {
                      switch(selectedProduct.edit){
                        case ProductEdit.Diff:
                          break;
                        case ProductEdit.Missing:
                          break;
                        case ProductEdit.Added:
                          selectedProduct.added = value.isNegative ? 0 : selectedProduct.added * 10 + value;
                          widget.database.upsertProduct(selectedProduct, selectedProduct.productName);
                          break;
                        case ProductEdit.Sold:
                          selectedProduct.sold = value.isNegative ? 0 : selectedProduct.sold * 10 + value;
                          widget.database.upsertProduct(selectedProduct, selectedProduct.productName);
                          break;
                        case ProductEdit.Remaining:
                          selectedProduct.remaining =  value.isNegative ? 0 : selectedProduct.remaining * 10 + value;
                          widget.database.upsertProduct(selectedProduct, selectedProduct.productName);
                          break;
                      }
                    });
                  }
                },
                onCalculateResult: (){
                  if(selectedProduct != null && selectedProduct.today){
                    setState(() {
                      switch(selectedProduct.edit){
                        case ProductEdit.Diff:
                          break;
                        case ProductEdit.Missing:
                          break;
                        case ProductEdit.Added:
                          widget.database.upsertProduct(selectedProduct, selectedProduct.productName);
                          break;
                        case ProductEdit.Sold:
                          calculateMissing(selectedProduct);
                          widget.database.upsertProduct(selectedProduct, selectedProduct.productName);
                          break;
                        case ProductEdit.Remaining:
                          calculateDiff(selectedProduct);
                          widget.database.upsertProduct(selectedProduct, selectedProduct.productName);
                          break;
                      }
                    });
                  }
                },
              ),
            ),
            Container(
              width: tableWidth,
              padding: EdgeInsets.only(left: 150.0, right: 8.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: p.map((List<ProductCount> list){
                  return Column(
                    children: list.map((ProductCount count){
                      if(count.productName == 'DATA' || count.productName == 'DATA1' || count.productName == 'DATA2' || count.productName == 'DATA3'){
                        String date = '${count.date.date.day} ' + dateMonth(count.date.date.month) + ' ${count.date.date.year}';
                        return Card(
                          margin: EdgeInsets.only(left: 8.0),
                          elevation: 0.0,
                          child: Container(
                            height: 50.0,
                            width: 400.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: count.today ? Colors.red[700] : null,
                              border: Border.all(width: 2.0, color: Colors.black12),
                            ),
                            child: Text(date, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: count.today ? Colors.white : null)),
                          ),
                        );
                      } else if (count.productName == 'DESCRIPTION' || count.productName == 'DESCRIPTION1' || count.productName == 'DESCRIPTION2' || count.productName == 'DESCRIPTION3'){
                        return Container(
                          margin: EdgeInsets.only(left: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: descriptionIcons.map((DescriptionDetail desc){
                              return Container(
                                height: 50.0,
                                width: 80.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(width: 2.0, color: Colors.black12),
                                ),
                                child: IconButton(
                                  icon: Icon(desc.icon, color: count.today ? desc.color : null),
                                  tooltip: desc.tooptip,
                                  onPressed: null,
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      } else {
                        return ProductCountWidget(
                          productCount: count,
                          database: widget.database,
                          onSelectedProduct: (selectedProduct, state){
                            setState(() {
                              for(int i = 0; i< list.length; i++){
                                list[i].editDiff = false;
                              }
                              selectedProduct.edit = state;
                              selectedProduct.editDiff = !selectedProduct.editDiff;
                            });
                            this.selectedProduct = selectedProduct;
                          },
                        );
                      }
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
            Column(
              children: widget.productDetailsList.map((ProductDetails details){
                String productName;
                if(details.productName == 'DATA1' || details.productName == 'DATA2' || details.productName == 'DATA3'){
                  productName = 'DATA';
                } else if (details.productName == 'DESCRIPTION' || details.productName == 'DESCRIPTION1' || details.productName == 'DESCRIPTION2' || details.productName == 'DESCRIPTION3'){
                  productName = 'DESCRIÇÃO';
                } else {
                  productName = details.productName;
                }
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(0.0),
                  child: InkWell(
                    onTap: (){
                      if(widget.productDetailsList.indexOf(details) != 0 || widget.productDetailsList.indexOf(details) != 1){
                        Navigator.push(context, MaterialPageRoute<Null>(
                            builder: (context){
                              return ProductDetailPage(detail: details, database: widget.database);
                            }
                        ));
                      }
                    },
                    child: Container(
                      height: 50.0,
                      width: 150.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black54),
                      ),
                      child: Text(productName),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: _addNewProduct,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
