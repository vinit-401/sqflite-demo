class DBHelper {
 ///may come from app constants(string name)
  static String databaseName = 'appName_products.db';
  static String tableName = 'Products';
  static int databaseVersion = 1;

  //---->schema database
  static String productIdColumnName = 'productId';
  static String productColumnName = 'productName';
  static String productCategoryColumnName = 'productCategory';
  static String productStockColumnName = 'productStock';
  static String productPriceColumnName = 'productPrice';

  static String createTableQuery = '''
   CREATE TABLE $tableName (
          $productIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $productColumnName TEXT NOT NULL,
          $productCategoryColumnName TEXT NOT NULL,
          $productStockColumnName INTEGER NOT NULL,
          $productPriceColumnName TEXT NOT NULL
        )
  ''';
}

