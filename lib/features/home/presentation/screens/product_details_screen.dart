import '../widgets/exports.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discount =
        ((product.oldPrice - product.price) / product.oldPrice * 100)
            .toStringAsFixed(0);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: ListView(
        children: [
          //product image
          Image.network(
            product.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //name
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    //price
                    Text(
                      'UGX ${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    if (product.isOnSale)
                      Text(
                        'UGX ${product.oldPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    if (product.isOnSale)
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          '$discount% OFF',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                //description
                const SizedBox(height: 16),
                Text(product.description, style: const TextStyle(fontSize: 16)),
                SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(cartProvider.notifier).addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} added to cart')),
                        );
                      },
                      child: const Text('Add to Cart'),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
