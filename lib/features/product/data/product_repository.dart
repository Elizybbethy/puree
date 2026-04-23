import "package:purees/features/home/presentation/exports.dart";

class ProductRepository {
  final ProductApiService _apiService = ProductApiService();

  Future<List<Product>> getProducts(int limit, int offset) async {
    try {
      return await _apiService.fetchProducts(limit, offset);
    } catch (e) {

      
      return [];
    }
  }
}