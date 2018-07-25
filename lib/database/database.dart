import 'package:inventory_app/data.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:inventory_app/model/product_count.dart';


class ProductDatabase {

  static final db_id = "id";
  static final db_day = "day";
  static final db_productName = "productName";
  static final db_prevDay = "prevDay";
  static final db_prevDayAdded = "prevDayAdded";
  static final db_diff = "diff";
  static final db_added = "added";
  static final db_sold = "sold";
  static final db_missing = "missing";
  static final db_remaining = "remaining";
  static final db_today = "today";
  static final db_editDiff = "editDiff";
  static final db_tableName = "DateTable";

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
    for(int i = 0; i < columnList.length; i++){
      String tableName = columnList[i].replaceAll(RegExp(r"\s+\b|\b\s"), "");
      await db.execute(
          "CREATE TABLE $tableName ("
              "$db_id INTEGER PRIMARY KEY,"
              "$db_productName TEXT,"
              "$db_day TEXT,"
              "$db_prevDay INTEGER,"
              "$db_prevDayAdded INTEGER,"
              "$db_diff INTEGER,"
              "$db_added INTEGER,"
              "$db_sold INTEGER,"
              "$db_missing INTEGER,"
              "$db_remaining INTEGER,"
              "$db_editDiff BIT,"
              "$db_today BIT)");
      print('Database created table $tableName');
    }
    print('Database was created');
  }

  Future<int> addProduct(ProductCount product, String tableName) async {
    var dbClient = await database;
    try {
      int res = await dbClient.insert("$tableName", product.toMap());
      print('Added Product Date $res'  +  ' with values ${product.toString()}' + ' to $tableName');
      return res;
    } catch (e){
      int res = await updateProduct(product, tableName);
      return res;
    }
  }

  Future<ProductCount> upsertProduct(ProductCount product, String tableName) async {
    var dbClient = await database;
    if(product.id == null){
      product.id = await dbClient.insert(tableName, product.toMap());
    } else {
      dbClient.update(tableName, product.toMap(), where: "id= ?", whereArgs: [product.id]);
    }
    print('Added Product Date with values ${product.id}' + ' to $tableName');
    return product;
  }

  Future<int> updateProduct(ProductCount product, String tableName) async {
    var dbClient = await database;
    int res = await dbClient.update("$tableName", product.toMap());
    print("DataTable updated $res"  +  ' with values $product' + ' to $tableName');
    return res;
  }

  Future rawUpdateProduct(ProductCount product, String tableName) async {
    await db.rawInsert(
        "INSERT OR REPLACE INTO $tableName ("
            "${product.id},"
            "${product.day},"
            "${product.productName},"
            "${product.prevDay},"
            "${product.prevDayAdded},"
            "${product.diff},"
            "${product.added},"
            "${product.sold},"
            "${product.missing},"
            "${product.remaining},"
            "${product.today},"
            "${product.editDiff})"
    " VALUES("
            "${product.id},"
            "${product.day},"
            "${product.productName},"
            "${product.prevDay},"
            "${product.prevDayAdded},"
            "${product.diff},"
            "${product.added},"
            "${product.sold},"
            "${product.missing},"
            "${product.remaining},"
            "${product.today},"
            "${product.editDiff})");
    print('Raw Inserted Product id ${product.id} to table $tableName');
  }

  Future closeDb() async {
    var dbClient = await database;
    dbClient.close();
  }

  Future<List<ProductCount>> getProducts(String tableName) async {
    var dbClient = await database;
    List<Map> result = await dbClient.query("$tableName");
    print("Got the data for you  ${result.length}");
    return result.map((Map m){
      return ProductCount.fromDb(m);
    }).toList();
  }

  Future<ProductCount> getSingleProduct(int id, String tableName) async {
    var dbClient = await database;
    var result = await dbClient.query("$tableName", where: "id = ?", whereArgs: [id]);

    if(result.length == 0) return null;
    print("Got data for product  ${result[0]}");
    return ProductCount.fromDb(result[0]);
  }

}