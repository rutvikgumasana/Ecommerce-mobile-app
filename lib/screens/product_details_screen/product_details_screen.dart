import 'package:ecommerce_app/components/network_image.dart';
import 'package:ecommerce_app/components/primary_button.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/product_update_screen/product_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.product.title ?? 'Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: widget.product.images?.length ?? 0,
                itemBuilder: (context, index) {
                  return CustomCachedImage(
                    imageUrl: homeController.formatUrl(widget.product.images?[index] ?? ''),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Product Title
                  Text(
                    widget.product.title ?? '',
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  //Product Price
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      '\$${widget.product.price?.toStringAsFixed(2) ?? ''}',
                      style: const TextStyle(fontSize: 20.0, color: Colors.green),
                    ),
                  ),
                  //Product Description
                  Text(
                    widget.product.description ?? '',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: PrimaryTextButton(
          title: 'Update Product',
          onTap: () {
            Get.to(() => ProductUpdateScreen(
                  product: widget.product,
                ));
          },
        ),
      ),
    );
  }
}
