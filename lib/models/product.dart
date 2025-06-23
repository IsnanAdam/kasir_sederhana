class Product {
  final String name;
  final int price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});

  // Tambahan untuk mendukung Map<Product, int>
  @override
  bool operator ==(Object other) {
    return other is Product &&
        other.name == name &&
        other.price == price &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ imageUrl.hashCode;
}   