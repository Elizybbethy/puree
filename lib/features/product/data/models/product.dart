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

  //covert to json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'oldPrice': oldPrice,
      'isOnSale': isOnSale,
      'description': description,
    };
  }

  //convert from json
  factory Product.fromJson(Map<String, dynamic> json) {
    // Support multiple possible API shapes (e.g. fakestoreapi uses 'title' and 'image')
    final dynamic priceVal = json['price'] ?? 0;
    final double price = (priceVal is num)
        ? priceVal.toDouble()
        : double.tryParse('$priceVal') ?? 0.0;

    final dynamic oldPriceVal =
        json['oldPrice'] ?? json['previousPrice'] ?? price;
    final double oldPrice = (oldPriceVal is num)
        ? oldPriceVal.toDouble()
        : double.tryParse('$oldPriceVal') ?? price;

    final String name = (json['title'] ?? json['name'] ?? '').toString();
    final String imageUrl =
        (json['image'] ?? json['imageUrl'] ?? '').toString();
    final bool isOnSale =
        (json['isOnSale'] is bool) ? json['isOnSale'] as bool : false;
    final String description = (json['description'] ?? '').toString();

    return Product(
      name: name,
      imageUrl: imageUrl,
      price: price,
      oldPrice: oldPrice,
      isOnSale: isOnSale,
      description: description,
    );
  }
}
