import 'package:flutter/material.dart';
import 'package:purees/features/home/presentation/widgets/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby purees'),
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
          SizedBox(
            // increased height so horizontal ProductCard list is visible
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyProducts.length,
              itemBuilder: (context, index) {
                final Product product = dummyProducts[index];
                return ProductCard(
                  name: product.name,
                  imageUrl: product.imageUrl,
                  price: product.price,
                  oldPrice: product.oldPrice,
                  isOnSale: product.isOnSale,
                  description: product.description,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
