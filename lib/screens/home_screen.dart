import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_item.dart';
import 'cart_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Cilok', price: 10000, imageUrl: 'assets/images/cilok.jpg'),
    Product(name: 'Baso Goreng', price: 8000, imageUrl: 'assets/images/baso.jpg'),
    Product(name: 'Nasi Goreng', price: 16000, imageUrl: 'assets/images/nasi_goreng.jpg'),
    Product(name: 'Kopi', price: 5000, imageUrl: 'assets/images/kopi.jpg'),
    Product(name: 'Teh', price: 3000, imageUrl: 'assets/images/teh.jpg'),
    Product(name: 'Susu', price: 4000, imageUrl: 'assets/images/susu.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().items.values.fold(0, (prev, qty) => prev + qty);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // AppBar hitam
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 32,
              width: 32,
            ),
            SizedBox(width: 10),
            Text(
              'WarTeh',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // Tulisan putih
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white), // Icon putih
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  );
                },
              ),
              if (cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$cartCount',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white), // Icon logout putih
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        color: Colors.grey[200],
        child: ListView(
          children: products
              .map((product) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ProductItem(product: product),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
