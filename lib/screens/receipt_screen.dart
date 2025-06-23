import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int total;
  final int bayar;
  final int kembalian;
  final String email;

  const ReceiptScreen({
    Key? key,
    required this.items,
    required this.total,
    required this.bayar,
    required this.kembalian,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ Ambil nama kasir dari email
    final kasir = email.split('@')[0];

    // ✅ Tanggal & waktu sekarang
    final DateTime now = DateTime.now();
    final String tanggal = DateFormat('dd-MM-yyyy HH:mm').format(now);

    // ✅ Hitung total qty dari item keranjang
    final int totalQty = items.fold(0, (sum, item) => sum + (item['qty'] as int));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Struk Pembayaran'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Warung Teteh",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Text("Kasir: $kasir"),
            Text("Tanggal: $tanggal"),
            const SizedBox(height: 16),

            const Text(
              "Qty   Nama Barang           SubTotal",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),

            // ✅ Tampilkan daftar item
            ...items.map((item) {
              final nama = item['nama'] ?? '';
              final qty = item['qty'] ?? 0;
              final totalItem = item['total'] ?? 0;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$qty"),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(nama.toString(), overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Text("Rp$totalItem"),
                ],
              );
            }),

            const Divider(height: 32),
            Text("Total Barang: $totalQty"),
            Text("Total: Rp$total"),
            Text("Tunai: Rp$bayar"),
            Text("Kembali: Rp$kembalian"),

            const Spacer(),
            const Divider(),
            const Center(
              child: Text("TERIMAKASIH", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Center(child: Text('"Selamat Menikmati"')),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Kembali ke dashboard
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("CETAK"),
            ),
          ],
        ),
      ),
    );
  }
}
