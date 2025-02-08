import 'package:demo_sqlite/controller/database_controller.dart';
import 'package:demo_sqlite/provider/product_list_provider.dart';
import 'package:demo_sqlite/theme/app_theme.dart';
import 'package:demo_sqlite/ui/product_add_screen.dart';
import 'package:demo_sqlite/ui/product_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductListProvider>(context, listen: false).getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListProvider>(
      builder: (BuildContext context, ProductListProvider productListProvider, Widget? child) {
        return Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            backgroundColor: kWhite,
            title: Text('Products'),
            surfaceTintColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    Provider.of<ProductListProvider>(context, listen: false).getDataFromDatabase();
                  },
                  icon: Icon(Icons.sync),
                ),
              )
            ],
          ),
          body: productListProvider.productList.isEmpty
              ? Center(
                  child: Text(
                    "No Data Available",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    isThreeLine: true,
                    title: Text(productListProvider.productList[index].productName ?? ''),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            productListProvider.productList[index].productCategory ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Price: \$${productListProvider.productList[index].productPrice}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Text(
                            "Stock: ${productListProvider.productList[index].productStock}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    onLongPress: () {
                      DatabaseController.deleteProduct(productListProvider.productList[index].productId!);
                      Provider.of<ProductListProvider>(context, listen: false).getDataFromDatabase();
                    },
                    trailing: IconButton(
                        onPressed: () {
                          Provider.of<ProductListProvider>(context, listen: false).setEditingController(
                            productName: productListProvider.productList[index].productName,
                            productCategory: productListProvider.productList[index].productCategory,
                            productStock: productListProvider.productList[index].productStock.toString(),
                            productPrice: productListProvider.productList[index].productPrice,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductEditScreen(
                                productId: productListProvider.productList[index].productId!,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit)),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: productListProvider.productList.length,
                shrinkWrap: true,
              ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: kGrey,
            onPressed: () {
              Provider.of<ProductListProvider>(context, listen: false).clearEditingController();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductScreen(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: kBlack,
              size: 28,
            ),
          ),
        );
      },
    );
  }
}
