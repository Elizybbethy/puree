import '../exports.dart';
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        ref.read(productProvider.notifier).fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby purees'),
        actions: [
          IconButton(
            icon: const CartBadge(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductCartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            const SliverToBoxAdapter(child: HomeSearchBar()),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            const SliverToBoxAdapter(child: BannerSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            const SliverToBoxAdapter(child: FlashSaleSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            const SliverToBoxAdapter(child: CategorySection()),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            // 🏷 Section Title
            const SliverToBoxAdapter(
              child: SectionHeader(title: 'Recommended for you'),
            ),

            // 🛍 Product Grid (Extracted)
            const ProductGridSection(),

            // 🔄 Initial Loading (only when empty)
            if (state.isLoading && state.products.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),

            // 👇 bottom spacing
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}
