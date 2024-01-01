
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saraswati_application_project/data/repositories/categories/firebase_storage_service.dart';
import 'package:saraswati_application_project/features/shop/models/product_model.dart';
import 'package:saraswati_application_project/utils/exceptions/firebase_exceptions.dart';
import 'package:saraswati_application_project/utils/exceptions/platform_exception.dart';

/// -- Repository for managing product related data and operations
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// -- Firestore instance for database interactions
  final _db = FirebaseFirestore.instance;


  /// -- Get Limited featured products
  Future<List<ProductModel>> getFeaturesProducts() async {
    try{
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please Try again';
    }
  }


  /// Upload Dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try{
      // Upload all product with their image
      final storage = Get.put(TFirebaseStorageService());

      // -- Loop through each product
      for (var product in products) {
        // -- Get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        // -- Upload image and get its URL
        final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());

        // -- Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        // -- Product list of images
        if (product.images != null && product.images!.isNotEmpty){
          List<String> imagesUrl = [];
          for (var image in product.images!){
            // -- Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // -- Upload image and get its URL
            final url = await storage.uploadImageData('Products/Images', assetImage, image);

            // -- Assign URL to product thumbnail attributes
            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        // -- Upload Variation Images
        if (product.productType == ProductType.variable.toString()){
          for (var variation in product.productVariations!) {
            // -- Get Image
            final assetImage = await storage.getImageDataFromAssets(variation.image);

            // -- Upload Image and get URL
            final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);

            // Assign URL to variation.image attribute
            variation.image = url;
          }
        }


        /// -- Store Product in Firestore
        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
    }on FirebaseException catch (e) {
      throw e.message!;
    }on SocketException catch (e) {
      throw e.message;
    }on PlatformException catch (e) {
      throw e.message!;
    }catch (e) {
      throw e.toString();
    }
  }
}