class ProductModel {
  String productName;
  num productPrice;
  String productLink;
  String productImage;
  String brand;
  String source;

  ProductModel(
      {this.productName,
      this.productPrice,
      this.productLink,
      this.productImage,
      this.brand,
      this.source});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productPrice = json['productPrice'];
    productLink = json['productLink'];
    productImage = json['productImage'];
    brand = json['brand'];
    source = json['source'];
  }
}
