import 'package:demo_sqlite/services/database/database_service.dart';

import '../model/product.dart';
import '../services/database/db_helper.dart';

class DatabaseController {
  static void insertProductsData(
    String productName,
    String productCategory,
    String productPrice,
    int productStock,
  ) async {
    final db = await DatabaseService.dbInstance.database;
    await db.insert(
      DBHelper.tableName,
      {
        DBHelper.productColumnName: productName,
        DBHelper.productCategoryColumnName: productCategory,
        DBHelper.productPriceColumnName: productPrice,
        DBHelper.productStockColumnName: productStock,
      },
    );
  }

  static Future<List<Product>> getProducts() async {
    final db = await DatabaseService.dbInstance.database;
    final data = await db.query(DBHelper.tableName);
    List<Product> products = data
        .map(
          (e) => Product(
            productName: e[DBHelper.productColumnName] as String,
            productCategory: e[DBHelper.productCategoryColumnName] as String,
            productPrice: e[DBHelper.productPriceColumnName] as String,
            productStock: e[DBHelper.productStockColumnName] as int,
            productId: e[DBHelper.productIdColumnName] as int,
          ),
        )
        .toList();
    return products;
  }

  static void deleteProduct(int id) async {
    final db = await DatabaseService.dbInstance.database;
    await db.delete(
      DBHelper.tableName,
      where: '${DBHelper.productIdColumnName} = ?',
      whereArgs: [
        id,
      ],
    );
  }

  static void updateProduct(Product product) async {
    final db = await DatabaseService.dbInstance.database;
    await db.update(
      DBHelper.tableName,
      {
        DBHelper.productColumnName: product.productName,
        DBHelper.productCategoryColumnName: product.productCategory,
        DBHelper.productPriceColumnName: product.productPrice,
        DBHelper.productStockColumnName: product.productStock,
      },
      where: '${DBHelper.productIdColumnName}=?',
      whereArgs: [
        product.productId,
      ],
    );
  }

  static Future<void> close() async {
    final db = await DatabaseService.dbInstance.database;
    db.close();
  }
}
