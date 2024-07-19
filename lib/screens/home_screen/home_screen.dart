import 'package:ecommerce_app/components/network_image.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:ecommerce_app/screens/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    //Call Api
    Future.delayed(Duration.zero).then(
      (value) {
        homeController.getProduct();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecommerce App'),
      ),
      body: Obx(
        () => homeController.loading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                itemCount: homeController.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Get.to(() => ProductDetailsScreen(product: homeController.products[index]));
                      },
                      child: CustomCachedImage(radius: 20, imageUrl: homeController.formatUrl(homeController.products[index].images?.first ?? homeController.products[index].category?.image ?? '')));
                }),
      ),
    );
  }
}
