class Product {
  final String id;
  final String productName;
  final String productCode;
  final String img;
  final String price;
  final String qty;
  final String totalPrice;

  Product(
      this.id,
      this.productName,
      this.productCode,
      this.img,
      this.price,
      this.qty,
      this.totalPrice,
      );

 factory Product.fromJson(Map<String, dynamic> productJson){
  return Product(
     productJson["_id"],
     productJson["ProductName"] ?? '',
     productJson["ProductCode"] ?? '',
     productJson["Img"] ?? '',
     productJson["UnitPrice"] ?? '',
     productJson["Qty"] ?? '',
     productJson["TotalPrice"] ?? '',
   );
  }

  Map<String, dynamic> toJson(){
   return {
     "id":id,
     "ProductName":productName,
     "ProductCode":productCode,
     "Img":img,
     "UnitPrice":price,
     "Qty":qty,
     "TotalPrice":totalPrice
   };
  }

}
