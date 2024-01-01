import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saraswati_application_project/data/repositories/user/user_repository.dart';
import 'package:saraswati_application_project/features/personalization/controllers/user_controller.dart';
import 'package:saraswati_application_project/features/personalization/screens/profile/profile.dart';
import 'package:saraswati_application_project/utils/constants/image_strings.dart';
import 'package:saraswati_application_project/utils/helpers/network_manager.dart';
import 'package:saraswati_application_project/utils/popups/full_screen_loader.dart';
import 'package:saraswati_application_project/utils/popups/loader.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();


  /// -- Init user data when Home Screen appears
  @override
  void onInit(){
    initializeNames();
    super.onInit();
  }

  /// -- Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try{
      // -- Start Loading
      TFullScreenLoader.OpenLoadingDialog('We are updating your information...', TImages.checkedIllustration);

      // -- Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // -- Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // -- Update user first & last name in the Firebase Firestore
      Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // -- Update the Rx User Value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // -- Remove Loader
      TFullScreenLoader.stopLoading();

      // -- Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your name has been updated');

      // -- Move to previous screen
      Get.off(() => const ProfileScreen());
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}