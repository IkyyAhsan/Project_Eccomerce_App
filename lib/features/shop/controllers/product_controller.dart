import 'package:get/get.dart';
import 'package:saraswati_application_project/data/repositories/products/product_repository.dart';
import 'package:saraswati_application_project/features/shop/models/product_model.dart';
import 'package:saraswati_application_project/utils/popups/loader.dart';

class ProductController extends GetxController{
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit(){
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try{
      // -- Show Loader while loading products
      isLoading.value = true;

      // -- Fetch Products
      final products = await productRepository.getFeaturesProducts();

      // -- Assign Products
      featuredProducts.assignAll(products);


    }catch (e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}