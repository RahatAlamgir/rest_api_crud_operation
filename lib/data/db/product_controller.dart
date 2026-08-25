import 'dart:convert';
import 'package:rest_api_crud_operation/data/model/product_model.dart';
import 'package:rest_api_crud_operation/data/url/urls.dart';
import 'package:http/http.dart' as http;

class ProductController {
  List<Data> products = [];

  Future getProduct() async {
    final response = await http.get(Uri.parse(Urls.readProductURL));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      ProductModel model = ProductModel.fromJson(jsonResponse);

      products = model.data ?? [];
    }
  }

  Future<bool> deleteProduct(String productID) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(productID)));

    if (response.statusCode == 200) {
      getProduct();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createProduct(Data data) async {
    final response = await http.post(
      Uri.parse(Urls.createProductURL),

      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        "ProductName": data.productName,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": data.img,
        "Qty": data.qty,
        "UnitPrice": data.unitPrice,
        "TotalPrice": data.totalPrice,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduct(Data data) async {
    final response = await http.post(
      Uri.parse(Urls.updateProduct(data.sId)),

      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        "ProductName": data.productName,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": data.img,
        "Qty": data.qty,
        "UnitPrice": data.unitPrice,
        "TotalPrice": data.totalPrice,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
