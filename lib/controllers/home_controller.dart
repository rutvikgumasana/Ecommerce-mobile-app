import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:ecommerce_app/utils/app_constants.dart';
import 'package:ecommerce_app/utils/network_dio/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final NetworkDioHttp networkDioHttp = NetworkDioHttp();
  RxList<ProductModel> products = <ProductModel>[].obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  RxList<TextEditingController> imageControllers = <TextEditingController>[].obs;
  RxBool loading = false.obs;

  // Get Product Api
  Future<void> getProduct() async {
    loading.value = true;
    var response = await networkDioHttp.getRequest(
      url: ApiAppConstants.apiEndPoint + ApiAppConstants.product,
      name: 'GetProduct',
      isHeader: false,
    );
    loading.value = false;
    if (response.data != null && response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> jsonData = response.data as List<dynamic>;
      List<ProductModel> productList = jsonData.map((item) => ProductModel.fromJson(item)).toList();

      // Update the products list
      products.value = productList;
    }
  }

  // Update Product Api
  Future<void> updateProduct({required ProductModel productData}) async {
    loading.value = true;
    var response = await networkDioHttp.putRequest(
      url: '${ApiAppConstants.apiEndPoint}${ApiAppConstants.product}/${productData.id}',
      bodyData: productData.toJson(),
      name: 'UpdateProduct',
      isHeader: false,
    );
    loading.value = false;
    if (response.data != null && response.statusCode == 200) {
      ProductModel product = ProductModel.fromJson(response.data);
      debugPrint('------------------- $product');

      Get.offAll(() => const HomeScreen());
    }
  }

  //Format Url
  String formatUrl(String url) {
    return url.replaceAll('"', '').replaceAll(r'\', '').replaceAll('[', '').replaceAll(']', '').trim();
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }
}
