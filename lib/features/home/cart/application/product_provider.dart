import '../../presentation/exports.dart';

final productProvider = StateNotifierProvider<ProductNotifier, ProductState>(
  (ref) => ProductNotifier(),
);

class ProductState {
  final List<Product> products;
  final bool isLoading;
  final bool hasMore;

  ProductState({
    this.products = const [],
    this.isLoading = false,
    this.hasMore = true,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? hasMore,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductApiService _api = ProductApiService();

  ProductNotifier() : super(ProductState()) {
    fetchInitial();
  }

  int _page = 0;
  final int _limit = 6;

  Future<void> fetchInitial() async {
    state = state.copyWith(isLoading: true);

    final products = await _api.fetchProducts(_limit, 0);

    state = state.copyWith(
      products: products,
      isLoading: false,
      hasMore: products.isNotEmpty,
    );
  }

  Future<void> fetchMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    _page++;
    final newProducts = await _api.fetchProducts(_limit, _page * _limit);

    state = state.copyWith(
      products: [...state.products, ...newProducts],
      isLoading: false,
      hasMore: newProducts.isNotEmpty,
    );
  }
}
