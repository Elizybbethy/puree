import '../presentation/exports.dart';

class ProductCartScreen extends ConsumerWidget {
  const ProductCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(item.product.imageUrl,width: 50,height: 50,),
                  title: Text(item.product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: UGX ${item.product.price.toStringAsFixed(0)}'),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              ref.read(cartProvider.notifier).decreaseQuantity(item.product);
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              ref.read(cartProvider.notifier).increaseQuantity(item.product);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(cartProvider.notifier).removeFromCart(item.product);
                    },
                  ),
                );
              },
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: UGX ${ref.watch(cartProvider.notifier).totalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      // Implement checkout functionality 
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                        );
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
    );
  }
}
