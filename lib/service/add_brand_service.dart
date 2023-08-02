import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbuy_admin/model/brand_model.dart';

class AddBrandService {
  imgUpload(XFile image) async {
    try {
      final path = 'files/${image.name}';
      final file = File(image.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final firebaseImgUrl = await snapshot.ref.getDownloadURL();
      return firebaseImgUrl;
    } catch (error) {
      return '';
    }
  }

  addBrand({required String brandImg, required String brandName}) async {
    final brandCollection = await FirebaseFirestore.instance
        .collection('pocketBuy')
        .doc('admin')
        .collection('brands')
        .doc(brandName);
    final brand = BrandModel(brandImg: brandImg, brandName: brandName);
    final brandjson = brand.toJson();
    await brandCollection.set(brandjson);
  }

  Future<List<BrandModel>> getbrands() async {
    List<BrandModel> brandList = [];
    final brandCollection = await FirebaseFirestore.instance
        .collection('pocketBuy')
        .doc('admin')
        .collection('brands')
        .get();
    List data = brandCollection.docs;
    for (var element in data) {
      BrandModel model = BrandModel(
          brandImg: element['brandImg'], brandName: element['brandName']);
      brandList.add(model);
    }
    return brandList;
  }
}
