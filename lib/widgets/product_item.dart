import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            product.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Rp. ${product.price}'),
        trailing: ElevatedButton(
          onPressed: () {
            cart.addToCart(product);
          },
          child: Text("Tambah"),
        ),
      ),
    );
  }
}
