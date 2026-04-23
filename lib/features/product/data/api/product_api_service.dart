import '../../../home/presentation/exports.dart';

class ProductApiService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts(int limit, int offset) async {
    final response = await _dio
        .get('https://fakestoreapi.com/products?limit=$limit&offset=$offset');

    final data = response.data as List;

    //simulate pagination usin offset
    final paginatedData = data.skip(offset).take(limit).toList();

    return paginatedData.map((json) {
      return Product(
        name: json['title'] ?? '',
        imageUrl: json['image'] ?? '',
        price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
        oldPrice: (json['oldPrice'] is num)
            ? (json['oldPrice'] as num).toDouble()
            : (json['price'] is num)
                ? (json['price'] as num).toDouble()
                : 0.0,
        isOnSale: json['isOnSale'] ?? false,
        description: json['description'] ?? '',
      );
    }).toList();
  }
}
