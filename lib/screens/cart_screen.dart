import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/cart_summary_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: cart.items.isEmpty
          ? Center(child: Text('Keranjang kosong'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: cart.items.entries.map((entry) {
                      return CartItemWidget(
                        product: entry.key,
                        quantity: entry.value,
                      );
                    }).toList(),
                  ),
                ),
                CartSummaryWidget(),
              ],
            ),
    );
  }
}
