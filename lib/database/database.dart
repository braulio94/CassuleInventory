import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:inventory_app/model/product_count.dart';


class ProductDatabase {

  static final ProductDatabase _instance = ProductDatabase._internal();
  static Database db;
  factory ProductDatabase() => _instance;

  Future<Database> get database async {
    if(db != null){
      return db;
    }
    db = await initDB();
    return db;
  }

  ProductDatabase._internal();

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "inventory.db");
    var thDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return thDB;
  }


  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE DateTable(day TEXT, productName TEXT, prevDay INTEGER, diff INTEGER, added INTEGER, sold INTEGER, missing INTEGER, today BIT, editDiff BIT)");
    print('Database was created');
  }

  Future<int> addProduct(ProductCount product) async {
    var dbClient = await database;
    int res = await dbClient.insert("DateTable", product.toMap());
    print('Added Product Date $res');
    return res;
  }

  Future closeDb() async {
    var dbClient = await database;
    dbClient.close();
  }

}