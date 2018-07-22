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

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory - July'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 50.0,
                margin: EdgeInsets.only(left: 150.0, top: statusBarHeight, right: 350.0),
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: productCountList.map((ProductCount count){
                    return Card(
                      margin: EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: 50.0,
                        width: 400.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: count.today ? Colors.red[900].withOpacity(0.1) : null,
                          border: Border.all(width: 2.0, color: Colors.black12),
                        ),
                        child: Text(count.day),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                height: 50.0,
                width: 150.0,
                margin: EdgeInsets.only(top: statusBarHeight),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2.0, color: Colors.black12),
                ),
                child: Text('DATA'),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                height: 50.0,
                margin: EdgeInsets.only(left: 150.0, right: 350.0),
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: productCountList.map((ProductCount count){
                    return ProductCountWidget(productCount: count);
                  }).toList(),
                ),
              ),
              Container(
                height: 50.0,
                width: 150.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2.0, color: Colors.black12),
                ),
                child: Text('COCA COLA'),
              ),
            ],
          ),

        ]
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
