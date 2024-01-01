import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:saraswati_application_project/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:saraswati_application_project/utils/constants/colors.dart';
import 'package:saraswati_application_project/utils/constants/sizes.dart';
import 'package:saraswati_application_project/utils/device/device_utility.dart';
import 'package:saraswati_application_project/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.primary : Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}