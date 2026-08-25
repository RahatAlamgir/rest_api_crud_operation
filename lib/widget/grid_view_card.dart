import 'package:flutter/material.dart';
import 'package:rest_api_crud_operation/data/db/product_controller.dart';
import 'package:rest_api_crud_operation/data/model/product_model.dart';
import 'package:rest_api_crud_operation/pages/add_update_product.dart';

class GridViewCard extends StatelessWidget {
  GridViewCard({super.key, required this.product, required this.fetchData});
  final Data product;
  final VoidCallback fetchData;

  ProductController productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            child: SizedBox(
              height: 110,
              width: double.infinity,
              child: Image.network(
                product.img.toString(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[100],
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: .all(10.0),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        product.productName.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),

                      Text(
                        "Qty: ${product.qty}",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "৳${product.unitPrice}",
                          maxLines: 1,

                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddUpdateProduct(product: product),
                                ),
                              );
                              fetchData();
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 18,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Product'),
                                  content: const Text(
                                    'Are you sure you want to delete this product?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        bool isSuccess = await productController
                                            .deleteProduct(
                                              product.sId.toString(),
                                            );

                                        if (isSuccess) {
                                          fetchData();
                                        }
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Icon(
                              Icons.delete_outline,
                              size: 18,
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
          ),
        ],
      ),
    );
  }
}
