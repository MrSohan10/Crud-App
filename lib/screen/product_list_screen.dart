import 'dart:convert';

import 'package:crud_app/screen/add_new_product_screen.dart';
import 'package:crud_app/screen/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool inProgress = false;

  @override
  void initState() {
    getProductList();
    super.initState();
  }

  Future<void> getProductList() async {
    inProgress = true;
    Response response =
        await get(Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData["status"] == "success") {
        for (Map<String, dynamic> productJson in responseData["data"]) {
          productList.add(Product.fromJson(productJson));
        }
      }
    }
    setState(() {});
    inProgress = false;
  }

  Future<void> deleteProduct(String productId) async {
    inProgress = true;
    setState(() {

    });
    Response response = await get(Uri.parse(
        "https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId"));
    if (response.statusCode == 200) {
      productList.clear();
      getProductList();
    } else {
      setState(() {});
      inProgress = false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Crud App'),
          actions: [
            IconButton(
              onPressed: () {
                productList.clear();
                getProductList();
              },
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewProductScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            productList.clear();
            getProductList();
          },
          child: inProgress
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return ProductItem(
                      product: productList[index],
                      onPresseDelete: (String productId) {
                        deleteProduct(productId);
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                ),
        ));
  }
}

