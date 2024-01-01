import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saraswati_application_project/common/widgets/appbar/appbar.dart';
import 'package:saraswati_application_project/common/widgets/brands/brand_card.dart';
import 'package:saraswati_application_project/common/widgets/layouts/grid_layout.dart';
import 'package:saraswati_application_project/common/widgets/products/sortable/sortable_products.dart';
import 'package:saraswati_application_project/common/widgets/texts/section_heading.dart';
import 'package:saraswati_application_project/utils/constants/sizes.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Heading
              const TSectionHeading(title: 'Brands', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              /// -- Brands
              TGridLayout(
                itemCount: 10, 
                mainAxisExtent: 80, 
                itemBuilder: (context, index) => TBrandCard(
                showBorder: true, 
                onTap: () => Get.to(() => const TSortableProducts()),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}