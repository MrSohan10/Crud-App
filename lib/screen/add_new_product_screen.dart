import 'dart:convert';

import 'package:crud_app/screen/product.dart';
import 'package:crud_app/screen_Style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key, this.product});

  final Product? product;

  @override
  State<AddNewProductScreen> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool inProgress = false;

  Future<void> addNewProduct() async {
    inProgress = true;
    setState(() {});
    final Product product = Product(
      " ",
      _nameController.text.trim(),
      _productCodeController.text.trim(),
      _imgController.text.trim(),
      _priceController.text.trim(),
      _quantityController.text.trim(),
      _totalPriceController.text.trim(),
    );
    // final Map<String, dynamic> inputMap = {
    //   "Img": _imgController.text.trim(),
    //   "ProductCode": _productCodeController.text.trim(),
    //   "ProductName": _nameController.text.trim(),
    //   "Qty": _quantityController.text.trim(),
    //   "TotalPrice": _totalPriceController.text.trim(),
    //   "UnitPrice": _priceController.text.trim()
    // };
    Response response = await post(
        Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      _imgController.clear();
      _productCodeController.clear();
      _nameController.clear();
      _quantityController.clear();
      _totalPriceController.clear();
      _priceController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Add Successfull")));
    } else if (response.statusCode == 400) {
      Text('Ener Unique product code');
    }

    setState(() {});
    inProgress = false;
  }

  Future<void> updateProduct() async {
    inProgress = true;
    setState(() {});
    final Product product = Product(
      " ",
      _nameController.text.trim(),
      _productCodeController.text.trim(),
      _imgController.text.trim(),
      _priceController.text.trim(),
      _quantityController.text.trim(),
      _totalPriceController.text.trim(),
    );

    //
    // final Map<String, dynamic> inputMap = {
    //   "Img": _imgController.text.trim(),
    //   "ProductCode": _productCodeController.text.trim(),
    //   "ProductName": _nameController.text.trim(),
    //   "Qty": _quantityController.text.trim(),
    //   "TotalPrice": _totalPriceController.text.trim(),
    //   "UnitPrice": _priceController.text.trim()
    // };
    Response response = await post(
        Uri.parse(
            "https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product!.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      _imgController.clear();
      _productCodeController.clear();
      _nameController.clear();
      _quantityController.clear();
      _totalPriceController.clear();
      _priceController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Update Successfull")));
    } else if (response.statusCode == 400) {
      Text('Enter Unique product code');
    }

    setState(() {});
    inProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: inValidate,
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration:
                      textFormStyle("Product Name", 'Enter product name'),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  validator: inValidate,
                  controller: _productCodeController,
                  textInputAction: TextInputAction.next,
                  decoration:
                      textFormStyle("Product code", 'Enter product code'),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  validator: inValidate,
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration:
                      textFormStyle("Quantity", 'Enter product quantity'),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  validator: inValidate,
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: textFormStyle("Price", 'Enter product price'),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  validator: inValidate,
                  controller: _totalPriceController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: textFormStyle("Total price", 'Enter total Price'),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  validator: inValidate,
                  controller: _imgController,
                  decoration: textFormStyle("Img", 'Enter product Image url'),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    height: 40,
                    width: 200,
                    child: inProgress
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.product == null) {
                                  addNewProduct();
                                } else {
                                  updateProduct();
                                }
                              }
                            },
                            child: widget.product != null
                                ? Text("Update")
                                : Text('Add'),
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? inValidate(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Enter value";
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _productCodeController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _totalPriceController.dispose();
    _imgController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.product != null) {
      _nameController.text = widget.product!.productName;
      _productCodeController.text = widget.product!.productCode;
      _quantityController.text = widget.product!.qty;
      _priceController.text = widget.product!.price;
      _totalPriceController.text = widget.product!.totalPrice;
      _imgController.text = widget.product!.img;
    }
    super.initState();
  }
}
