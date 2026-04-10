import '../../presentation/exports.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]) {
    // Load persisted cart on initialization (fire-and-forget)
    loadCart();
  }

  void addToCart(Product product) {
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
    saveCart();
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.product.name != product.name).toList();
    saveCart();
  }

  void increaseQuantity(Product product) {
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
    saveCart();
  }

  void decreaseQuantity(Product product) {
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
    saveCart();
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
        final List<dynamic> jsonList = jsonDecode(cartData);
        state = jsonList.map((json) => CartItem.fromJson(json)).toList();
      }
    } catch (e) {
      // If parsing fails, clear stored cart to avoid repeated failures
      // and keep the in-memory cart empty.
      // Optionally log the error during development.
      // print('Failed to load cart: $e\n$st');
    }
  }

  Future<void> saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = jsonEncode(state.map((item) => item.toJson()).toList());
      await prefs.setString('cart', cartData);
    } catch (e) {
      // print('Failed to save cart: $e');
    }
  }
}
