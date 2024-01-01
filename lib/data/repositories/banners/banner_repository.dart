import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saraswati_application_project/features/shop/models/banner_model.dart';
import 'package:saraswati_application_project/utils/exceptions/firebase_exceptions.dart';
import 'package:saraswati_application_project/utils/exceptions/format_exceptions.dart';
import 'package:saraswati_application_project/utils/exceptions/platform_exception.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// -- Variables
  final _db = FirebaseFirestore.instance;

  /// -- Get all Order related to current user
  Future<List<BannerModel>> fetchBanners() async {
    try{
      final result = await _db.collection('Banners').where('active', isEqualTo: true).get();
      return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }


  
  /// -- Upload Banners to the Cloud Firebase
  
}