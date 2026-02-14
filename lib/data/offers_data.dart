import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Offer {
  final int id;
  final String title;
  final String description;
  final double originalPrice;
  final double discountPrice;
  final int discountPercent;
  final Color color;
  final IconData icon;
  final Duration duration;

  const Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercent,
    required this.color,
    required this.icon,
    required this.duration,
  });
}

final List<Offer> allOffers = [
  Offer(
    id: 101,
    title: 'عرض العائلة الكبيرة',
    description: '3 عبوات حفاضات مقاس 3 + عبوة مناديل مبللة مجانية',
    originalPrice: 19000,
    discountPrice: 14500,
    discountPercent: 24,
    color: AppColors.primaryPink,
    icon: Icons.card_giftcard,
    duration: const Duration(days: 3),
  ),
  Offer(
    id: 102,
    title: 'عرض المولود الجديد',
    description: 'مجموعة كاملة: حفاضات مقاس 1 + مقاس 2 + كريم حفاضة',
    originalPrice: 13000,
    discountPrice: 9900,
    discountPercent: 24,
    color: AppColors.babyBlue,
    icon: Icons.bolt,
    duration: const Duration(days: 5),
  ),
  Offer(
    id: 103,
    title: 'عرض نهاية الشهر',
    description: 'خصم 30% على جميع منتجات العناية بالبشرة',
    originalPrice: 10000,
    discountPrice: 7000,
    discountPercent: 30,
    color: AppColors.softGreen,
    icon: Icons.percent,
    duration: const Duration(days: 7),
  ),
];
