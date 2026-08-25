import 'package:flutter/material.dart';
import 'package:rest_api_crud_operation/data/db/product_controller.dart';
import 'package:rest_api_crud_operation/data/model/product_model.dart';

class AddUpdateProduct extends StatefulWidget {
  AddUpdateProduct({super.key, this.product});

  Data? product;

  @override
  State<AddUpdateProduct> createState() => _AddUpdateProductState();
}

class _AddUpdateProductState extends State<AddUpdateProduct> {
  ProductController productController = ProductController();
  bool isUpdate = false;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productIMGController = TextEditingController();
  TextEditingController productQTYController = TextEditingController();
  TextEditingController productUnitPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      productNameController.text = widget.product!.productName.toString();
      productIMGController.text = widget.product!.img.toString();
      productQTYController.text = widget.product!.qty.toString();
      productUnitPriceController.text = widget.product!.unitPrice.toString();
      isUpdate = true;
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    productIMGController.dispose();
    productQTYController.dispose();
    productUnitPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isUpdate ? "Update Product" : "Add Product",
          style: TextStyle(fontWeight: .w600),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: productIMGController,
              builder: (context, value, child) {
                final url = value.text.trim();
                return Container(
                  height: 120,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: url.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Column(
                              mainAxisAlignment: .center,
                              children: [
                                Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.grey,
                                  size: 32,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Invalid Image URL",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              color: Colors.grey,
                              size: 32,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Image Preview",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),

            TextField(
              controller: productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                prefixIcon: const Icon(Icons.shopping_bag_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Image URL Field
            TextField(
              controller: productIMGController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                prefixIcon: const Icon(Icons.link_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: productQTYController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'QTY',
                      prefixIcon: const Icon(Icons.numbers_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: productUnitPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Unit Price',
                      prefixIcon: const Icon(Icons.attach_money_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  isUpdate
                      ? await productController.updateProduct(
                          Data(
                            sId: widget.product!.sId,
                            productName: productNameController.text.trim(),
                            img: productIMGController.text.trim(),
                            qty: int.tryParse(productQTYController.text) ?? 1,
                            unitPrice:
                                int.tryParse(productUnitPriceController.text) ??
                                0,
                            totalPrice:
                                (int.tryParse(
                                      productUnitPriceController.text,
                                    ) ??
                                    0) *
                                (int.tryParse(productQTYController.text) ?? 1),
                          ),
                        )
                      : await productController.createProduct(
                          Data(
                            productName: productNameController.text.trim(),
                            img: productIMGController.text.trim(),
                            qty: int.tryParse(productQTYController.text) ?? 1,
                            unitPrice:
                                int.tryParse(productUnitPriceController.text) ??
                                0,
                            totalPrice:
                                (int.tryParse(
                                      productUnitPriceController.text,
                                    ) ??
                                    0) *
                                (int.tryParse(productQTYController.text) ?? 1),
                          ),
                        );
                  if (context.mounted) Navigator.pop(context);
                },

                label: Text(
                  isUpdate ? "Update Product" : "Add Product",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
