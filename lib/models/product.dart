class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final bool isNew;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    this.isNew = false,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}
