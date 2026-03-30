class Product {
  final String name;
  final String imageUrl;
  final double price;
  final double oldPrice;
  final bool isOnSale;
  final String description;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.oldPrice,
    required this.isOnSale,
    required this.description,
  });
}