class Product {
  Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productCategory,
    required this.productStock,
  });

  final String? productName;
  final String? productPrice;
  final String? productCategory;
  final int? productStock;
  final int? productId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      productName: json["productName"],
      productPrice: json["productPrice"],
      productCategory: json["productCategory"],
      productStock: json["productStock"],
      productId: json["productId"]);

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productPrice": productPrice,
        "productCategory": productCategory,
        "productStock": productStock,
        "productId": productId,
      };
}
