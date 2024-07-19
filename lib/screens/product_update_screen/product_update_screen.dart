import 'package:ecommerce_app/components/custom_textfield.dart';
import 'package:ecommerce_app/components/primary_button.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductUpdateScreen extends StatefulWidget {
  final ProductModel product;

  const ProductUpdateScreen({super.key, required this.product});

  @override
  ProductUpdateScreenState createState() => ProductUpdateScreenState();
}

class ProductUpdateScreenState extends State<ProductUpdateScreen> {
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    homeController.titleController.text = widget.product.title ?? '';
    homeController.priceController.text = widget.product.price.toString();
    homeController.descriptionController.text = widget.product.description ?? '';
    homeController.categoryController.text = widget.product.category?.name ?? '';
    homeController.imageControllers.value = widget.product.images?.map((url) => TextEditingController(text: homeController.formatUrl(url))).toList() ?? [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: homeController.formKey,
          child: ListView(
            children: [
              // Title Field
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(
                  controller: homeController.titleController,
                  labelText: 'Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
              ),
              // Price Field
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: homeController.priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ),
              // Description Field
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: homeController.descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: homeController.categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: Row(
                  children: [
                    const Text('Images :-', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    //Add Image Urls Button
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: InkWell(
                        onTap: () {
                          homeController.imageControllers.add(TextEditingController());
                        },
                        child: Icon(
                          Icons.add_circle_outlined,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Image Urls
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeController.imageControllers.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: homeController.imageControllers[index],
                            decoration: InputDecoration(labelText: 'Image URL ${index + 1}'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            homeController.imageControllers.removeAt(index);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => homeController.loading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(15),
                child: PrimaryTextButton(
                  title: 'Save Product',
                  onTap: () {
                    //On Save Product
                    if (homeController.formKey.currentState!.validate()) {
                      homeController.updateProduct(
                          productData: ProductModel(
                        id: widget.product.id,
                        title: homeController.titleController.text,
                        price: int.tryParse(homeController.priceController.text),
                        description: homeController.descriptionController.text,
                        category: Category(name: homeController.categoryController.text, id: widget.product.category?.id, image: widget.product.category?.image),
                        images: homeController.imageControllers.map((controller) => controller.text).toList(),
                      ));
                    }
                  },
                ),
              ),
      ),
    );
  }
}
