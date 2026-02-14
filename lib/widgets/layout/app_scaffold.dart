import 'package:flutter/material.dart';
import 'package:prince_baby_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_colors.dart';
import '../cart_drawer.dart';
import '../whatsapp_button.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == '/') return 0;
    if (location.startsWith('/products')) return 1;
    if (location.startsWith('/blog')) return 2;
    if (location.startsWith('/contact')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryPink, AppColors.babyBlue],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('👶', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              l.appTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        actions: [
          // Cart button
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => _showCartSheet(context),
              ),
              Consumer<CartProvider>(
                builder: (context, cart, _) {
                  if (cart.totalItems == 0) return const SizedBox.shrink();
                  return Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryPink,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cart.totalItems}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          // Theme toggle
          IconButton(
            icon: Icon(
              isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
            ),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
          // Language toggle
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => context.read<LocaleProvider>().toggleLocale(),
          ),
        ],
      ),
      drawer: _buildDrawer(context, l),
      body: Stack(children: [child, const WhatsAppButton()]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/products');
              break;
            case 2:
              context.go('/blog');
              break;
            case 3:
              context.go('/contact');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: l.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag_outlined),
            activeIcon: const Icon(Icons.shopping_bag),
            label: l.navProducts,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.article_outlined),
            activeIcon: const Icon(Icons.article),
            label: l.navBlog,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.mail_outlined),
            activeIcon: const Icon(Icons.mail),
            label: l.navContact,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, AppLocalizations l) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryPink, Color(0xFFB03A6B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text('👶', style: TextStyle(fontSize: 28)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l.appTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l.heroSubtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem(context, Icons.home_outlined, l.navHome, '/'),
          _drawerItem(
            context,
            Icons.shopping_bag_outlined,
            l.navProducts,
            '/products',
          ),
          _drawerItem(
            context,
            Icons.straighten_outlined,
            l.navSizeGuide,
            '/size-guide',
          ),
          _drawerItem(
            context,
            Icons.medical_information_outlined,
            l.navTips,
            '/tips',
          ),
          _drawerItem(context, Icons.help_outline, l.navFaq, '/faq'),
          _drawerItem(context, Icons.article_outlined, l.navBlog, '/blog'),
          _drawerItem(context, Icons.mail_outlined, l.navContact, '/contact'),
          const Divider(),
          _drawerItem(
            context,
            Icons.shopping_cart_outlined,
            l.cartTitle,
            null,
            onTap: () {
              Navigator.pop(context);
              _showCartSheet(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    String? route, {
    VoidCallback? onTap,
  }) {
    final isActive =
        route != null && GoRouterState.of(context).uri.path == route;
    return ListTile(
      leading: Icon(icon, color: isActive ? AppColors.primaryPink : null),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? AppColors.primaryPink : null,
        ),
      ),
      selected: isActive,
      selectedTileColor: AppColors.primaryPink.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap:
          onTap ??
          () {
            Navigator.pop(context);
            if (route != null) context.go(route);
          },
    );
  }

  void _showCartSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const CartDrawer(),
    );
  }
}
