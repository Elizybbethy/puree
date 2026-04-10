import '../../presentation/exports.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  final notifier = CartNotifier();
  // Ensure we attempt to load persisted cart when the provider is created.
  // This covers cases where the notifier constructor may not be re-run (hot reload)
  // but the provider factory is invoked.
  notifier.loadCart();
  return notifier;
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]) {
    // Load persisted cart on initialization (fire-and-forget)
    loadCart();
  }

  Future<void> addToCart(Product product) async {
    final existingIndex =
        state.indexWhere((item) => item.product.name == product.name);
    if (existingIndex != -1) {
      // If the product is already in the cart, increase the quantity
      final updatedItem = CartItem(
        product: state[existingIndex].product,
        quantity: state[existingIndex].quantity + 1,
      );
      state = [
        ...state.sublist(0, existingIndex),
        updatedItem,
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // If the product is not in the cart, add it with quantity 1
      state = [...state, CartItem(product: product, quantity: 1)];
    }
    await saveCart();
  }

  Future<void> removeFromCart(Product product) async {
    state = state.where((item) => item.product.name != product.name).toList();
    await saveCart();
  }

  Future<void> increaseQuantity(Product product) async {
    final index = state.indexWhere((item) => item.product.name == product.name);
    if (index >= 0) {
      final updatedItem = CartItem(
        product: state[index].product,
        quantity: state[index].quantity + 1,
      );
      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    }
    await saveCart();
  }

  Future<void> decreaseQuantity(Product product) async {
    final index = state.indexWhere((item) => item.product.name == product.name);
    if (index >= 0 && state[index].quantity > 1) {
      final updatedItem = CartItem(
        product: state[index].product,
        quantity: state[index].quantity - 1,
      );
      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    } else if (index >= 0) {
      removeFromCart(product);
    }
    await saveCart();
  }

  // void clearCart() {
  //   state = [];
  // }
  double get totalPrice {
    return state.fold<double>(
        0.0, (total, item) => total + item.product.price * item.quantity);
  }

  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString('cart');
      if (cartData != null && cartData.isNotEmpty) {
        // debug: show loaded raw JSON
        // ignore: avoid_print
        print('loadCart: raw cart data = $cartData');
        final List<dynamic> jsonList = jsonDecode(cartData);
        state = jsonList.map((json) => CartItem.fromJson(json)).toList();
        // ignore: avoid_print
        print('loadCart: restored ${state.length} items');
      }
    } catch (e) {
      // If parsing fails, clear stored cart to avoid repeated failures
      // and keep the in-memory cart empty.
      // Optionally log the error during development.
      // ignore: avoid_print
      print('Failed to load cart: $e');
    }
  }

  Future<void> saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = jsonEncode(state.map((item) => item.toJson()).toList());
      // debug: show data being saved
      // ignore: avoid_print
      print('saveCart: saving ${state.length} items -> $cartData');
      await prefs.setString('cart', cartData);
    } catch (e) {
      // print('Failed to save cart: $e');
      // ignore: avoid_print
      print('Failed to save cart: $e');
    }
  }
}
