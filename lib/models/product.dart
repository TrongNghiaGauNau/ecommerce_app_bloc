class Product {
  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.category,
    required this.price,
    this.amountInCart = 0,
    this.description,
    this.isChecked = false,
    this.priceInCart = 0,
  });

  final int id;
  final String title;
  final String image;
  final String category;
  final double price;
  final String? description;
  int amountInCart;
  bool isChecked;
  double priceInCart;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] as String,
      category: map['category'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
      amountInCart: 0,
    );
  }
}
