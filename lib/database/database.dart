import 'package:inventory_app/data.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:inventory_app/model/product_count.dart';
import 'package:inventory_app/model/inventory_date.dart';

class ProductDatabase {

  static final db_id = "id";
  static final db_dateId = "dateId";
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
    _createInventoryDateTable(db);
    _createSoftDrinkTable(db);
    _createBeerTables(db);
    _createFoodTables(db);
    print('Database was created');
  }

  _createInventoryDateTable(Database db) async {
    await db.execute(
        "CREATE TABLE ${InventoryDate.db_date_table} ("
            "$db_id INTEGER PRIMARY KEY,"
            "${InventoryDate.date_year} INTEGER,"
            "${InventoryDate.date_month} INTEGER,"
            "${InventoryDate.date_day} INTEGER,"
            "${InventoryDate.date_hour} INTEGER,"
            "${InventoryDate.date_minute} INTEGER,"
            "${InventoryDate.date_second} INTEGER,"
            "${InventoryDate.date_millisecond} INTEGER,"
            "${InventoryDate.date_microsecond} INTEGER)");
    print('${InventoryDate.db_date_table} table created');
  }

  _createSoftDrinkTable(Database db) async {
    for (int i = 0; i < softDrinkList.length; i++) {
      String tableName = softDrinkList[i].productName.replaceAll(RegExp(r"\s+\b|\b\s"), "");
      await db.execute(
          "CREATE TABLE $tableName ("
              "$db_id INTEGER PRIMARY KEY,"
              "$db_dateId INTEGER,"
              "$db_productName TEXT,"
              "$db_prevDay INTEGER,"
              "$db_prevDayAdded INTEGER,"
              "$db_diff INTEGER,"
              "$db_added INTEGER,"
              "$db_sold INTEGER,"
              "$db_missing INTEGER,"
              "$db_remaining INTEGER,"
              "$db_editDiff BIT,"
              "$db_today BIT,"
              "FOREIGN KEY ($db_dateId) REFERENCES ${InventoryDate.db_date_table} ($db_id))");
      print('Database created table $tableName');
    }
  }

  _createBeerTables(Database db) async {
    for (int i = 0; i < beerList.length; i++) {
      String tableName = beerList[i].productName.replaceAll(RegExp(r"\s+\b|\b\s"), "");
      try{
        await db.execute(
            "CREATE TABLE $tableName ("
                "$db_id INTEGER PRIMARY KEY,"
                "$db_dateId INTEGER,"
                "$db_productName TEXT,"
                "$db_prevDay INTEGER,"
                "$db_prevDayAdded INTEGER,"
                "$db_diff INTEGER,"
                "$db_added INTEGER,"
                "$db_sold INTEGER,"
                "$db_missing INTEGER,"
                "$db_remaining INTEGER,"
                "$db_editDiff BIT,"
                "$db_today BIT,"
                "FOREIGN KEY ($db_dateId) REFERENCES ${InventoryDate.db_date_table} ($db_id))");
      } catch(e){}
      print('Database created table $tableName');
    }
  }

  _createFoodTables(Database db) async {
    for (int i = 0; i < foodList.length; i++) {
      String tableName = foodList[i].productName.replaceAll(RegExp(r"\s+\b|\b\s"), "");
      try{
        await db.execute(
            "CREATE TABLE $tableName ("
                "$db_id INTEGER PRIMARY KEY,"
                "$db_dateId INTEGER,"
                "$db_productName TEXT,"
                "$db_prevDay INTEGER,"
                "$db_prevDayAdded INTEGER,"
                "$db_diff INTEGER,"
                "$db_added INTEGER,"
                "$db_sold INTEGER,"
                "$db_missing INTEGER,"
                "$db_remaining INTEGER,"
                "$db_editDiff BIT,"
                "$db_today BIT,"
                "FOREIGN KEY ($db_dateId) REFERENCES ${InventoryDate.db_date_table} ($db_id))");
      } catch(e){}
      print('Database created table $tableName');
    }
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
            "${product.dateId},"
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
            "${product.dateId},"
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

  Future<ProductCount> upsertProduct(ProductCount product, String tableName) async {
    var dbClient = await database;
    if(product.id == null){
      product.id = await dbClient.insert(tableName, product.toMap());
      product.date = await fetchInventoryDate(product.id);
    } else {
      dbClient.update(tableName, product.toMap(), where: "id= ?", whereArgs: [product.id]);
    }
    print('Added Product Date with values ${product.id}' + ' to $tableName');
    return product;
  }

  Future<InventoryDate> upsertInventoryDate() async {
    var dbClient = await database;
    InventoryDate inventoryDate = InventoryDate(date: DateTime.now());
    inventoryDate.id = await dbClient.insert(InventoryDate.db_date_table, inventoryDate.toMap());
    print('Saved date id: ${inventoryDate.id} day: ${inventoryDate.date.day} month: ${inventoryDate.date.month}');
    return inventoryDate;
  }

  Future closeDb() async {
    var dbClient = await database;
    dbClient.close();
  }

  Future<List<ProductCount>> getProducts(String tableName) async {
    var dbClient = await database;
    List<Map> result = await dbClient.query("$tableName");
    return result.map((Map m){
      return ProductCount.fromDb(m);
    }).toList();
  }

  Future<List<InventoryDate>> getInventoryDates(String tableName) async {
    var dbClient = await database;
    List<Map> result = await dbClient.query("$tableName");

    return result.map((Map m){
      return InventoryDate.fromMap(m);
    }).toList();
  }

  Future<InventoryDate> fetchInventoryDate(int id) async {
    var dbClient = await database;
    List<Map> results = await dbClient.query(InventoryDate.db_date_table, where: "id = ?", whereArgs: [id]);
    InventoryDate inventoryDate = InventoryDate.fromMap(results[0]);
    return inventoryDate;
  }

  Future<ProductCount> getSingleProduct(int id, String tableName) async {
    var dbClient = await database;
    var result = await dbClient.query("$tableName", where: "id = ?", whereArgs: [id]);
    if(result.length == 0) return null;
    print("Got data for product  ${result[0]}");
    ProductCount product = ProductCount.fromDb(result[0]);
    product.date = await fetchInventoryDate(product.id);
    return product;
  }

}