import 'package:get/get.dart';
import 'package:saraswati_application_project/features/shop/controllers/product/images_controller.dart';
import 'package:saraswati_application_project/features/shop/models/product_model.dart';
import 'package:saraswati_application_project/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController{
  static VariationController get instance => Get.find();

  /// -- Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  /// -- Select Attribute, and Variation
  void onAttributeSelected(ProductModel product, attributeName, attributeValue){
    // -- When attribute is selected we will first add that attribute to the selectedAttributes
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
      (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes), 
      orElse: () => ProductVariationModel.empty(),
    );

    // -- Show the selected variation image as a main page
    if (selectedVariation.image.isNotEmpty){
      ImagesController.instance.selectedProductImage.value = selectedVariation.image;
    }

    // -- Assign selected variation
    this.selectedVariation.value = selectedVariation;

    // -- Update selected product variation status
    getProductVariationStockStatus();
  }

  /// -- Check if selected attributes matches any variation attribute
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes){
    // -- if selectedAttributes contains 3 attributes and current variation contains 2 then return.
    if (variationAttributes.length != selectedAttributes.length) return false;

    // -- if any of the attributes is different then return e.g. [Green, Large] * [Green, Small]
    for (final key in variationAttributes.keys){
      // -- Attributes[key] = Value which could be [Green, Small, Cotton] etc.
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }
  /// -- Check Attribute avaibility / Stock in variation
  Set<String?> getAttributesAvaibilityInVariation(List<ProductVariationModel> variations, String attributeName){
    // -- Pass the variations to check which attributes are available and stock is not 0
    final availableVariationAttributeValues = variations
    .where((variation) => 
    // Check empty / Out of stock attributes
    variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.stock > 0)
    // Fetch all non-empty attributes of variations
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

      return availableVariationAttributeValues;
  }

  String getVariationPrice(){
    return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  /// -- Check Product variation stock status
  void getProductVariationStockStatus(){
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// -- Reset Selected Attributes when switching products
  void resetSelectedAttributes(){
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}