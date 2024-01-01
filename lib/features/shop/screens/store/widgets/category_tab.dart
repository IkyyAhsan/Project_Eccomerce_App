import 'package:flutter/material.dart';
import 'package:saraswati_application_project/common/widgets/brands/brand_show_case.dart';
import 'package:saraswati_application_project/common/widgets/layouts/grid_layout.dart';
import 'package:saraswati_application_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:saraswati_application_project/common/widgets/texts/section_heading.dart';
import 'package:saraswati_application_project/features/shop/models/category_model.dart';
import 'package:saraswati_application_project/utils/constants/image_strings.dart';
import 'package:saraswati_application_project/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Brands
                  const TBrandShowCase(images: [TImages.productImage1, TImages.productImage2, TImages.productImage3],),
                  const TBrandShowCase(images: [TImages.productImage1, TImages.productImage2, TImages.productImage3],),
                  const SizedBox(height: TSizes.spaceBtwItems,),
      
                  /// -- Products
                  TSectionHeading(title: 'You might like', onPressed: (){}),
                  const SizedBox(height: TSizes.spaceBtwItems,),
      
                  TGridLayout(itemCount: 9, itemBuilder: (_, index) => const TProductCardVertical()),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  
                ],
              ),
              ),
      ],
    );
  }
}