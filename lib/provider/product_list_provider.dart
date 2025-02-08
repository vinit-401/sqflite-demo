import 'package:flutter/material.dart';

import '../controller/database_controller.dart';
import '../model/product.dart';

class ProductListProvider with ChangeNotifier {
  List<Product> _productList = [];

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productCategoryController = TextEditingController();
  final TextEditingController _productStockController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  TextEditingController get productNameController => _productNameController;
  TextEditingController get productPriceController => _productPriceController;
  TextEditingController get productStockController => _productStockController;
  TextEditingController get productCategoryController => _productCategoryController;
  List<Product> get productList => _productList;

  void getDataFromDatabase() async {
    _productList = await DatabaseController.getProducts();
    notifyListeners();
  }

  void clearEditingController() {
    _productStockController.clear();
    _productNameController.clear();
    _productCategoryController.clear();
    _productPriceController.clear();
  }

  void setEditingController(
      {required productName, required productCategory, required productStock, required productPrice}) {
    _productNameController.text = productName;
    _productCategoryController.text = productCategory;
    _productPriceController.text = productPrice;
    _productStockController.text = productStock;
    notifyListeners();
  }
}
