import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/payment_dialog.dart';

class CartSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final total = cart.totalPrice;

    return Card(
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: Rp. $total',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: total > 0
                  ? () async {
                      final bayar = await showDialog<int>(
                        context: context,
                        builder: (_) => PaymentDialog(total: total),
                      );

                      if (bayar != null && bayar >= total) {
                        await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => AlertDialog(
                            title: Text('Struk Pembayaran'),
                            content: Text(
                              'Total: Rp. $total\nBayar: Rp. $bayar\nKembalian: Rp. ${bayar - total}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // tutup struk
                                  context.read<CartProvider>().clearCart(); // kosongkan keranjang
                                  Navigator.of(context).pop(); // keluar dari cart screen (opsional)
                                },
                                child: Text('Selesai'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  : null,
              child: Text('Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
