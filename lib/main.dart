import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BRImo Mobile Banking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isBalanceVisible = true;

  final List<Map<String, dynamic>> mainMenus = [
  {"icon": Icons.send, "label": "Transfer", "color": const Color(0xFF003C8F)},
  {"icon": Icons.bolt, "label": "Top Up", "color": const Color(0xFF003C8F)},
  {"icon": Icons.receipt, "label": "Tagihan", "color": const Color(0xFF003C8F)},
  {"icon": Icons.qr_code_scanner, "label": "QRIS", "color": const Color(0xFF003C8F)},
  {"icon": Icons.credit_card, "label": "e-Money", "color": const Color(0xFF003C8F)},
  {"icon": Icons.trending_up, "label": "Investasi", "color": const Color(0xFF003C8F)},
  {"icon": Icons.card_giftcard, "label": "Promo", "color": const Color(0xFF003C8F)},
  {"icon": Icons.more_horiz, "label": "Lainnya", "color": const Color(0xFF003C8F)},
  ];

  final List<Map<String, dynamic>> promos = [
    {"title": "Diskon Listrik 30%", "desc": "Khusus pembayaran via BRImo", "bgColor": const Color(0xFFFFE0B5)},
    {"title": "Cashback GoFood", "desc": "Min. transaksi Rp50.000", "bgColor": const Color(0xFFD4F1F9)},
    {"title": "Beli Pulsa Gratis", "desc": "Periode 1-31 Maret 2026", "bgColor": const Color(0xFFE8D9FF)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF003C8F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.account_balance, color: Colors.white, size: 28),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo,', style: TextStyle(fontSize: 12, color: Colors.black54)),
            Text('Sahrul Adhim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black54),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(),
              const SizedBox(height: 20),
              _buildQuickActions(),
              const SizedBox(height: 24),
              _buildPromoBanner(),
              const SizedBox(height: 24),
              _buildRecentTransactions(),
              const SizedBox(height: 16),
              _buildInfoSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Menu ${_getMenuName(index)} dalam pengembangan'),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF003C8F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'QR'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Promo'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Saya'),
        ],
      ),
    );
  }

  String _getMenuName(int index) {
    const menus = ['Beranda', 'Riwayat', 'QR', 'Promo', 'Saya'];
    return menus[index];
  }

  Widget _buildBalanceCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF003C8F), Color(0xFF004C99)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Saldo', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      SizedBox(height: 8),
                      Text(
                        'Rp 4.800.000',
                        style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isBalanceVisible = !_isBalanceVisible;
                      });
                    },
                    child: Icon(
                      _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBalanceDetail('Tabungan', 'Rp 2.400.000'),
                  _buildBalanceDetail('Giro', 'Rp 2.400.000'),
                  _buildBalanceDetail('Deposito', 'Rp 5.000.000'),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF003C8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Lihat Semua Rekening'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceDetail(String title, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          _isBalanceVisible ? amount : '••••••••',
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Fitur Cepat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.9,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: mainMenus.length,
          itemBuilder: (context, index) {
            final menu = mainMenus[index];
            return _buildMenuItem(menu['icon'], menu['label'], menu['color']);
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fitur $label akan segera hadir'), duration: const Duration(seconds: 1)),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Promo & Penawaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Lihat semua', style: TextStyle(color: Color(0xFF003C8F), fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: promos.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final promo = promos[index];
              return Container(
                width: 250,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: promo['bgColor'],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.local_offer, color: Color(0xFF003C8F), size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(promo['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 4),
                          Text(promo['desc'], style: const TextStyle(fontSize: 11, color: Colors.black54)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Transaksi Terakhir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              _buildTransactionItem(
                icon: Icons.send,
                title: 'Transfer',
                subtitle: 'Ke BNI - Ahmad Fauzi',
                amount: '- Rp 250.000',
                date: 'Hari ini',
                color: Colors.blue,
              ),
              const Divider(height: 1),
              _buildTransactionItem(
                icon: Icons.bolt,
                title: 'Top Up',
                subtitle: 'Gojek',
                amount: '- Rp 100.000',
                date: 'Kemarin',
                color: Colors.green,
              ),
              const Divider(height: 1),
              _buildTransactionItem(
                icon: Icons.receipt,
                title: 'Pembayaran',
                subtitle: 'PLN - 123456789',
                amount: '- Rp 350.000',
                date: 'Kemarin',
                color: Colors.orange,
              ),
              const Divider(height: 1),
              _buildTransactionItem(
                icon: Icons.qr_code_scanner,
                title: 'QRIS Payment',
                subtitle: 'Warung Makan Bahari',
                amount: '- Rp 45.000',
                date: '2 hari lalu',
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required String date,
    required Color color,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          Text(date, style: const TextStyle(fontSize: 10, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(Icons.call, 'Call BRI', '147'),
          _buildInfoItem(Icons.chat, 'Chat', '24 Jam'),
          _buildInfoItem(Icons.help, 'Bantuan', 'FAQ'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String subtitle) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF003C8F), size: 28),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.black54)),
        ],
      ),
    );
  }
}