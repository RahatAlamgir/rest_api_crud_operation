import 'package:flutter/material.dart';
import 'package:rest_api_crud_operation/data/db/product_controller.dart';
import 'package:rest_api_crud_operation/data/model/product_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await productController.getProduct();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products", style: TextStyle(fontWeight: .w600)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.grid_view))],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.78,
        ),
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          Data product = productController.products[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: .symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Image.network(
                      product.img.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),

                  Column(
                    crossAxisAlignment: .start,

                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                product.productName.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),

                              Text(
                                product.qty.toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "${product.unitPrice} BDT",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 20,
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Colors.blueAccent,
                            ),
                          ),

                          IconButton(
                            iconSize: 20,
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
