import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartItemWidget({required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: Image.asset(
          product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Rp. ${product.price} x $quantity = Rp. ${product.price * quantity}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                cart.decreaseQuantity(product);
              },
            ),
            Text('$quantity', style: TextStyle(fontSize: 16)),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                cart.addToCart(product);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                cart.removeFromCart(product);
              },
            ),
          ],
        ),
      ),
    );
  }
}
