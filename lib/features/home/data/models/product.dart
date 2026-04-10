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
    return Product(
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      oldPrice: (json['oldPrice'] as num).toDouble(),
      isOnSale: json['isOnSale'] as bool,
      description: json['description'],
    );
  }
}
