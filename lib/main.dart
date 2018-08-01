
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/calc_buttons.dart';
import 'package:inventory_app/data.dart';
import 'package:inventory_app/model/description_details.dart';
import 'package:inventory_app/model/edit_product.dart';
import 'package:inventory_app/model/inventory_date.dart';
import 'package:inventory_app/model/product_count.dart';
import 'dart:core';
import 'package:flutter/scheduler.dart';
import 'package:inventory_app/model/product_details.dart';
import 'package:inventory_app/product_widget.dart';
import 'package:inventory_app/database/database.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cassule Inventory',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ScrollController _scrollController = new ScrollController();
  ProductDatabase database;
  List<InventoryDate> inventoryDateList = List();
  ProductCount selectedProduct;

  @override
  initState() {
    super.initState();
    database = ProductDatabase();
    database.initDB();
    setUpList();
  }

  setUpList() async {
    List<ProductCount> list = await database.getProducts("DESCRIPTION");
    for(ProductCount count in list){
      List<ProductCount> countList = [];
      for(int i = 0; i < columnList.length; i++){
        String tableName = columnList[i].productName.replaceAll(RegExp(r"\s+\b|\b\s"), "");
        if(tableName != 'DATA'){
          ProductCount product =  await database.getSingleProduct(count.id, tableName);
          countList.add(product);
        }
      }
      setState(() {
        p.add(countList);
      });
    }
  }

  @override
  void dispose() {
    database.closeDb();
    super.dispose();
  }

  void _addNewProduct() async {
    List<ProductCount> list = [];
    for(int i = 0; i< columnList.length; i++){
      String productName = columnList[i].productName.replaceAll(RegExp(r"\s+\b|\b\s"), "");
      if(productName == 'DATA'){
        database.upsertInventoryDate(productName);
      } else {
        if(p.isNotEmpty){
          p.last[i-1].today = false;
        }
        ProductCount product = ProductCount(productName, p.isNotEmpty ? p.last[i-1].remaining : 0, p.isNotEmpty ? p.last[i-1].added : 0, 0, 0, 0, 0, 0, false, true);
        product = await database.upsertProduct(product, productName);
        list.add(product);
        if(p.isNotEmpty){
          database.upsertProduct(p.last[i-1], productName);
        }
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
      appBar: AppBar(
        title: Text('Inventario - Julho'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: CalculatorButtons(
                    keyboardWidth: keyboardWidth,
                    onNumberPressed: (int value){
                      print('Number pressed is $value');
                      if(selectedProduct != null && selectedProduct.today){
                        print('Selected product id is ${selectedProduct.id} and name is ${selectedProduct.productName}');
                        setState(() {
                          switch(selectedProduct.edit){
                            case ProductEdit.Diff:
                              //selectedProduct.diff = selectedProduct.diff * 10 + value;
                              break;
                            case ProductEdit.Missing:
                              //selectedProduct.missing = selectedProduct.missing * 10 + value;
                              break;
                            case ProductEdit.Added:
                              selectedProduct.added = selectedProduct.added * 10 + value;
                              break;
                            case ProductEdit.Sold:
                              selectedProduct.sold = selectedProduct.sold * 10 + value;
                              break;
                            case ProductEdit.Remaining:
                              selectedProduct.remaining =  selectedProduct.remaining * 10 + value;
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
                          print('Product name: ${count.productName} and dateId: ${count.date.date}');
                          switch(count.productName){
//                            case 'DATA':
//                              return Card(
//                                margin: EdgeInsets.only(left: 8.0),
//                                elevation: 0.0,
//                                child: Container(
//                                  height: 50.0,
//                                  width: 400.0,
//                                  alignment: Alignment.center,
//                                  decoration: BoxDecoration(
//                                    color: count.today ? Colors.red[700] : null,
//                                    border: Border.all(width: 2.0, color: Colors.black12),
//                                  ),
//                                  child: Text(count.day, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: count.today ? Colors.white : null)),
//                                ),
//                              );
                            case 'DESCRIPTION':
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
                            default:
                              return ProductCountWidget(
                                productCount: count,
                                database: database,
                                onSelectedProduct: (selectedProduct, state){
                                  setState(() {
                                    for(int i = 0; i< list.length; i++){
                                      list[i].editDiff = false;
                                    }
                                    selectedProduct.edit = state;
                                    selectedProduct.editDiff = !selectedProduct.editDiff;
                                  });
                                  print('Selected product id is ${selectedProduct.id} and name is ${selectedProduct.productName}');
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
                  children: columnList.map((ProductDetails details){
                    return Card(
                      elevation: 4.0,
                      margin: EdgeInsets.all(0.0),
                      child: Container(
                        height: 50.0,
                        width: 150.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2.0, color: Colors.black12),
                        ),
                        child: Text(details.productName),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewProduct,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
