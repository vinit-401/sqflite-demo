import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controller/database_controller.dart';
import '../model/product.dart';
import '../provider/product_list_provider.dart';
import '../theme/app_theme.dart';

GlobalKey<FormState> editKey = GlobalKey();

class ProductEditScreen extends StatelessWidget {
  final int productId;
  const ProductEditScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, ProductListProvider productListProvider, Widget? child) {
      return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: Text('Update Product'),
          backgroundColor: kWhite,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Form(
              key: editKey,
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      if (editKey.currentState!.validate()) {
                        DatabaseController.updateProduct(
                          Product(
                            productId: productId,
                            productName: productListProvider.productNameController.text,
                            productPrice: productListProvider.productPriceController.text,
                            productCategory: productListProvider.productCategoryController.text,
                            productStock: int.parse(
                              productListProvider.productStockController.text,
                            ).round(),
                          ),
                        );
                         Navigator.pop(context);
                         Provider.of<ProductListProvider>(context,listen: false).getDataFromDatabase();
                        Provider.of<ProductListProvider>(context, listen: false).clearEditingController();
                      }
                    },
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black12)),
                    child: Text(' Update '),
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
