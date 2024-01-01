import 'package:flutter/material.dart';
import 'package:saraswati_application_project/common/widgets/appbar/appbar.dart';
import 'package:saraswati_application_project/common/widgets/appbar/tabbar.dart';
import 'package:saraswati_application_project/common/widgets/brands/brand_card.dart';
import 'package:saraswati_application_project/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:saraswati_application_project/common/widgets/layouts/grid_layout.dart';
import 'package:saraswati_application_project/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:saraswati_application_project/common/widgets/texts/section_heading.dart';
import 'package:saraswati_application_project/features/shop/controllers/category_controller.dart';
import 'package:saraswati_application_project/features/shop/screens/store/widgets/category_tab.dart';
import 'package:saraswati_application_project/utils/constants/colors.dart';
import 'package:saraswati_application_project/utils/constants/sizes.dart';
import 'package:saraswati_application_project/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(onPressed: () {}, iconColor: TColors.black ,),
          ],
        ),
        body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
              expandedHeight: 440,
      
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    /// -- Search Bar
                    const SizedBox(height: TSizes.spaceBtwItems,),
                      const TSearchContainer(
                        text: 'Search in Store', showBorder: true, showBackground: false,),
                    const SizedBox(height: TSizes.spaceBtwSections,),
      
                    /// -- Feature Brands
                    TSectionHeading(title: 'Featured Brands', onPressed: (){}),
                    const SizedBox(height: TSizes.spaceBtwItems / 1.5),
      
                    /// -- Brands GRID
                    TGridLayout(itemCount: 4, mainAxisExtent: 80, itemBuilder: (_, index) {
                      return const TBrandCard(showBorder: true);
                    }
                    ),
                  ],
                ),
              ),

              /// Tabs
              bottom: TTabBar(tabs: categories.map((category) => Tab(child: Text(category.name),)).toList(),),
            ),
          ];
        }, 
        body: TabBarView(
          children: categories.map((category) => TCategoryTab(category: category,)).toList()
          ),
      ),
      ),
    );
  }
}

