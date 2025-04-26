import 'package:flutter/material.dart';
import 'package:shoping/models/product-model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel? profuctModel;
  const ProductDetailScreen({super.key, this.profuctModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
