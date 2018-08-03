
import 'package:flutter/material.dart';
import 'package:inventory_app/data.dart';
import 'package:inventory_app/database/database.dart';
import 'package:inventory_app/pages/home_page.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cassule Inventory',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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
    return HomePage(database: database, productDetailsList: foodList);
  }
}
