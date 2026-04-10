import '../exports.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartProvider.notifier).totalPrice.toStringAsFixed(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          //Address section
          const Text(
            'Delivery Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your delivery address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16),

          //Payment method section
          const Text(
            'Payment Method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('Credit/Debit Card'),
                trailing: Radio(
                  value: 'card',
                  groupValue: 'card',
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text('Mobile Money'),
                trailing: Radio(
                  value: 'mobile_money',
                  groupValue: 'card',
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Cash on Delivery'),
                trailing: Radio(
                  value: 'cash',
                  groupValue: 'card',
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          //Order summary section
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...cartItems.map((item) => ListTile(
                title: Text(item.product.name),
                subtitle: Text('Quantity: ${item.quantity}'),
                trailing: Text('UGX ${(item.product.price * item.quantity).toStringAsFixed(0)}'),
              )),
          const Divider(),
          // Total price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'UGX $totalPrice',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

            ],

          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order placed successfully!')),
              );
            },
            child: const Text('Place Order'),
          ),
        ]
      ),
    );
  }
}
