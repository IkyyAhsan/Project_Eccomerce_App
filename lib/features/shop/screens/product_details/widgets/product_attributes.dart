import 'package:flutter/material.dart';
import 'package:saraswati_application_project/common/widgets/chips/choice_chip.dart';
import 'package:saraswati_application_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:saraswati_application_project/common/widgets/texts/product_price_text.dart';
import 'package:saraswati_application_project/common/widgets/texts/product_title_text.dart';
import 'package:saraswati_application_project/common/widgets/texts/section_heading.dart';
import 'package:saraswati_application_project/utils/constants/colors.dart';
import 'package:saraswati_application_project/utils/constants/sizes.dart';
import 'package:saraswati_application_project/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// -- Selected Attribute Pricing & Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              /// -- Title, Price, and Stock Status
              Row(
                children: [
                  const TSectionHeading(title: 'Variation', showActionButton: false,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          TProductTitleText(title: 'Price  : ', smallSize: true,),
                          ///Sale Price
                          TProductPriceText(price: '63.200')
                    ],
                  ),

                  /// -- Stock
                  Row(
                    children: [
                      const TProductTitleText(title: 'Stock : ', smallSize: true,),
                      Text('In Stock', style: Theme.of(context).textTheme.titleMedium,),
                    ],
                  )
                    ],
                  ),
                  
                ],
              ),
              /// Variation Description
              const TProductTitleText(title: 'Liquid lipstick dengan tekstur mousse yang nyaman dipakai di bibir. \nDiformulasikan khusus untuk membuat bibirmu nyaman menggunakannya.,',
              smallSize: true,
              maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),

        ///Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Colors', showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'Brown Dreamer', selected: false, onSelected: (value){},),
                TChoiceChip(text: 'Joyful Orange', selected: false, onSelected: (value){},),
                TChoiceChip(text: 'Rose Ballerina', selected: false, onSelected: (value){},),
                TChoiceChip(text: 'Pink Sweetheart', selected: true, onSelected: (value){},),
                TChoiceChip(text: 'Artisan Mauve', selected: false, onSelected: (value){},),
              ]
            )
          ],
        ),
      ],
    );
  }
}

