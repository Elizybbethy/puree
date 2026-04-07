import '../presentation/widgets/exports.dart';

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
                    leading: Image.network(item.product.imageUrl),
                    title: Text(item.product.name),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: Text('UGX ${(item.product.price * item.quantity).toStringAsFixed(0)}'),
                    );
                },
                ),
    );
  }
}