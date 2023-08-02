import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocketbuy_admin/model/product_model.dart';

class ProductService {
  addProduct(ProductModel productModel) async {
    final productCollection = await FirebaseFirestore.instance
        .collection('pocketBuy')
        .doc('admin')
        .collection('products');
    DocumentReference productFile =
        productCollection.doc(productModel.productName);
    await productFile.set(productModel.toJson());
  }

    deleteProduct(String name) async {
    await FirebaseFirestore.instance
        .collection('pocketBuy')
        .doc('admin')
        .collection('products')
        .doc(name)
        .delete();
  }
}
