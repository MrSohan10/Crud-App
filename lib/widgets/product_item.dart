import 'package:crud_app/screen/add_new_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product, required this.onPresseDelete});

  final Product product;
  final Function (String) onPresseDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(product.img),
        title: Text(product.productName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.productCode),
            Text(product.totalPrice),
            Text(product.qty),
          ],
        ),
        trailing: Text("\$${product.price}"),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return productActionDialog(context);
              });
        },
      ),
    );
  }

  AlertDialog productActionDialog(BuildContext context) {
    return AlertDialog(
              title: Text('Select Action'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                   AddNewProductScreen(product: product,)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                    onTap: () {
                      Navigator.pop(context);
                      onPresseDelete(product.id);
                    },
                  ),
                ],
              ),
            );
  }
}
