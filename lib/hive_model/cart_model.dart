class CartItem {
  int productId;
  String productName;
  double price;
  int quantity;
  String imageUrl;
  String description;

  CartItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.description,
  });
}
