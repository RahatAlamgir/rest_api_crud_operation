import 'package:flutter/material.dart';
import 'package:rest_api_crud_operation/data/db/product_controller.dart';
import 'package:rest_api_crud_operation/pages/add_update_product.dart';
import 'package:rest_api_crud_operation/widget/grid_view_card.dart';
import 'package:rest_api_crud_operation/widget/list_view_card.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductController productController = ProductController();

  bool isGrid = true;

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

        actions: [
          IconButton(
            onPressed: () async {
              isGrid = !isGrid;
              await fetchData();
            },
            icon: Icon(isGrid ? Icons.grid_view : Icons.list),
          ),
        ],
      ),

      body: isGrid
          ? GridView.builder(
              padding: .all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.78,
              ),
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                return GridViewCard(
                  product: productController.products[index],
                  fetchData: () => fetchData(),
                );
              },
            )
          : ListView.builder(
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                return ListViewCard(
                  product: productController.products[index],
                  fetchData: () => fetchData(),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUpdateProduct()),
          );

          fetchData();
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
