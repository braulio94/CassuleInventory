import 'package:flutter/material.dart';
import 'package:inventory_app/data.dart';
import 'package:inventory_app/model/product_count.dart';
import 'dart:core';
import 'package:flutter/scheduler.dart';
import 'package:inventory_app/product_widget.dart';

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

  Iterable<Widget> _buildInventoryData() {
    List<Widget> listOfItem = <Widget>[];

    for (ProductCount count in productCountList) {
      listOfItem.add(
        ProductCountWidget(productCount: count)
      );
    }
    return listOfItem;
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory - July'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: 150.0,
            margin: EdgeInsets.only(left: 150.0, top: statusBarHeight, right: 350.0),
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: _buildInventoryData(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: statusBarHeight),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 150.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.black12),
                        color: Colors.white,
                      ),
                      child: Text('Nome do Producto'),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 150.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2.0, color: Colors.black12),
                      ),
                      child: Text('Cuca Garrafa'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (productCountList.isNotEmpty) {
              productCountList.elementAt(productCountList.length - 1).today =
                  false;
            }
            productCountList.add(ProductCount(DateTime.now().toString(), 0, 0, 0, 0, 0, false, true));
            //_diff = '';
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
