import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/database_controller.dart';
import '../provider/product_list_provider.dart';
import '../theme/app_theme.dart';

class AddProductScreen extends StatefulWidget {

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext contest, ProductListProvider productListProvider, Widget? child) {
      return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: Text('Add Product'),
          backgroundColor: kWhite,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Form(
              key: key,
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: decorationCustom('Product Name'),
                    autofocus: true,
                    controller: productListProvider.productNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.trim().length < 3) {
                        return "minimum length 3 required";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: decorationCustom('Product Category'),
                    controller: productListProvider.productCategoryController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.trim().length < 3) {
                        return "minimum length 3 required";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: decorationCustom('Product Price'),
                    keyboardType: TextInputType.number,
                    controller: productListProvider.productPriceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: decorationCustom('Product Stock'),
                    controller: productListProvider.productStockController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        DatabaseController.insertProductsData(
                          productListProvider.productNameController.text,
                          productListProvider.productCategoryController.text,
                          productListProvider.productPriceController.text,
                          int.parse(
                            productListProvider.productStockController.text,
                          ),
                        );
                        Provider.of<ProductListProvider>(context, listen: false).clearEditingController();
                        Provider.of<ProductListProvider>(context, listen: false).getDataFromDatabase();
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black12)),
                    child: Text('Add Product'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
