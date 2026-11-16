import 'package:flutter/material.dart';

import '../theme.dart';
import 'jelajah_page.dart';
import 'beranda_page.dart';
import 'profil_page.dart';

/// Shell dengan bottom navigation 5 tab (Figma).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _items = <(IconData, String)>[
    (Icons.home_outlined, 'Beranda'),
    (Icons.explore_outlined, 'Jelajah'),
    (Icons.assignment_outlined, 'Pesanan'),
    (Icons.chat_bubble_outline, 'Chat'),
    (Icons.person_outline, 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: IndexedStack(
        index: _index,
        children: [
          const BerandaPage(),
          const JelajahPage(),
          _Placeholder(
            icon: Icons.receipt_long_outlined,
            title: 'Belum Ada Pesanan',
            message: 'Pesanan kamu akan muncul di sini.',
          ),
          _Placeholder(
            icon: Icons.chat_bubble_outline,
            title: 'Belum Ada Chat',
            message: 'Mulai percakapan dengan penyedia jasa.',
          ),
          const ProfilPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 6, left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_items.length, (i) {
                final (icon, label) = _items[i];
                final active = i == _index;
                final color = active ? AppColors.primary : AppColors.secondary;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _index = i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColors.primarySoft
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(icon, size: 22, color: color),
                          ),
                          const SizedBox(height: 2),
                          FittedBox(
                            child: Text(
                              label,
                              style: AppText.body(10,
                                  color: color,
                                  weight: active
                                      ? FontWeight.w600
                                      : FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(title, style: AppText.heading(16)),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppText.body(13, color: AppColors.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
