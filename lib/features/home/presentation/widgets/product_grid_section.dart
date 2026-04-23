import '../exports.dart';


class ProductGridSection extends ConsumerWidget {
  const ProductGridSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productProvider);

    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index < state.products.length) {
              final product = state.products[index];
              return ProductCard(product: product);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
          childCount: state.products.length + (state.hasMore ? 1 : 0),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
      ),
    );
  }
}
