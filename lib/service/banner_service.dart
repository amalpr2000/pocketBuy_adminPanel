
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class BannerService{

imgUpload(XFile image) async {
    try {
      final path = 'bannerImages/${image.name}';
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

   addBanner({required String bannerImg}) async {
    final brandCollection = await FirebaseFirestore.instance
        .collection('pocketBuy')
        .doc('admin')
        .collection('banners').add({'imageUrl':bannerImg}); 
  }


}