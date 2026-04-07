import 'package:purees/features/home/presentation/widgets/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = dummyProducts.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby purees'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductCartScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          HomeSearchBar(),
          SizedBox(height: 10),
          BannerSection(),
          SizedBox(height: 10),
          FlashSaleSection(),
          SizedBox(height: 10),
          CategorySection(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
