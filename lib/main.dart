import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/data.dart';
import 'package:inventory_app/model/product_count.dart';
import 'dart:core';
import 'package:flutter/scheduler.dart';
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


  @override
  void initState() {
    super.initState();
    database = ProductDatabase();
    database.initDB();
  }

  @override
  void dispose() {
    database.closeDb();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario - Julho'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 150.0, right: 350.0),
                  child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: p.map((List<ProductCount> list){
                      return Column(
                        children: list.map((ProductCount count){
                          switch(count.productName){
                            case 'DATA':
                              return Card(
                                margin: EdgeInsets.only(left: 8.0),
                                elevation: 0.0,
                                child: Container(
                                  height: 50.0,
                                  width: 400.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: count.today ? Colors.red[900].withOpacity(0.1) : null,
                                    border: Border.all(width: 2.0, color: Colors.black12),
                                  ),
                                  child: Text(count.day, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                ),
                              );
                            case 'COCA COLA':
                              return ProductCountWidget(productCount: count);
                            case 'CUCA LATA':
                              return ProductCountWidget(productCount: count);
                            case 'EKA GARRAFA':
                              return ProductCountWidget(productCount: count);
                          }
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ),
                Column(
                  children: columnList.map((String value){
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
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState((){
            List<ProductCount> list = [];
            for(int i = 0; i< p.last.length; i++){
              p.last[i].today = false;
              list.add(
                  ProductCount(p.last[i].productName, DateFormat.yMMMd().format(DateTime.now()), p.last[i].remaining, p.last[i].added, 0, 0, 0, 0, 0, false, true)
              );
            }
            p.add(list);
          });
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
