import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../providers/cart_provider.dart';
import '../screens/receipt_screen.dart';

class PaymentDialog extends StatefulWidget {
  final int total;

  const PaymentDialog({Key? key, required this.total}) : super(key: key);

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void _handlePayment() async {
    final input = _controller.text;
    final bayar = int.tryParse(input);

    if (bayar == null) {
      setState(() {
        _errorText = 'Inputkan berupa angka';
      });
      return;
    }

    if (bayar < widget.total) {
      setState(() {
        _errorText = 'Uang tidak cukup!';
      });
      return;
    }

    // Ambil keranjang dari provider
    final cart = context.read<CartProvider>();
    final items = cart.items.entries.map((entry) {
      final product = entry.key;
      final qty = entry.value;
      return {
        'nama': product.name,
        'qty': qty,
        'total': qty * product.price,
      };
    }).toList();

    final kembalian = bayar - widget.total;
    final email = FirebaseAuth.instance.currentUser?.email ?? 'kasir@unknown.com';

    // Tutup dialog
    Navigator.pop(context);

    // Buka struk
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReceiptScreen(
          items: items,
          total: widget.total,
          bayar: bayar,
          kembalian: kembalian,
          email: email,
        ),
      ),
    );

    // Reset keranjang
    cart.clearCart();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Masukkan Uang Pembeli'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: 'Nominal Bayar',
          errorText: _errorText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _handlePayment,
          child: Text('Proses'),
        ),
      ],
    );
  }
}
