import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Product {
  final int id;
  final String name;
  final String category;
  final String? size;
  final String description;
  final List<String> features;
  final Color color;
  final double rating;
  final double price;
  final String? badge;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    this.size,
    required this.description,
    required this.features,
    required this.color,
    required this.rating,
    required this.price,
    this.badge,
    required this.image,
  });
}

final List<Product> allProducts = [
  Product(
    id: 1,
    name: 'حفاضات برنس - مقاس 1',
    category: 'حفاضات',
    size: '1',
    description:
        'حفاضات برنس الأكثر شهرة، مثالية للأطفال حديثي الولادة 2-5 كجم مع إمتصاص فائق وجوانب مطاطة.',
    features: [
      'إمتصاص فائق',
      'جوانب مطاطة',
      'ملمس قطني ناعم',
      'حماية من التسريب',
    ],
    color: AppColors.babyBlue,
    rating: 4.9,
    price: 4500,
    badge: 'الأكثر مبيعاً',
    image:
        'https://images.unsplash.com/photo-1544126592-807daa2b565b?auto=format&fit=crop&q=80&w=800',
  ),
  Product(
    id: 2,
    name: 'حفاضات برنس - مقاس 3',
    category: 'حفاضات',
    size: '3',
    description:
        'حفاضات برنس للأطفال 4-9 كجم، تصميم مريح يضمن حماية تدوم طويلاً.',
    features: [
      'إمتصاص فائق',
      'جوانب مطاطة',
      'حماية من التسريب',
      'لطيفة على البشرة',
    ],
    color: AppColors.primaryPink,
    rating: 4.9,
    price: 5500,
    badge: 'جودة عالمية',
    image:
        'https://images.unsplash.com/photo-1622290291468-a28f7a7dc6a8?auto=format&fit=crop&q=80&w=800',
  ),
  Product(
    id: 3,
    name: 'حفاضات عائلي - مقاس 4',
    category: 'حفاضات',
    size: '4',
    description:
        'حفاضات عائلي الاقتصادية، توفر حماية ممتازة وجودة عالية بسعر موفر.',
    features: ['حماية إقتصادية', 'إمتصاص جيد', 'حماية من التسريب'],
    color: AppColors.softGreen,
    rating: 4.7,
    price: 4000,
    badge: 'توفير',
    image:
        'https://images.unsplash.com/photo-1555252333-9f8e92e65df9?auto=format&fit=crop&q=80&w=800',
  ),
  Product(
    id: 4,
    name: 'حفاضات بلاند - مقاس 5',
    category: 'حفاضات',
    size: '5',
    description:
        'حفاضات بلاند بتصميمها المريح وحمايتها التي تدوم طويلاً للأطفال 11-25 كجم.',
    features: ['تصميم مريح', 'حماية طويلة', 'حواجز مانعة للتسريب'],
    color: AppColors.coralRed,
    rating: 4.8,
    price: 6000,
    image:
        'https://images.unsplash.com/photo-1544126592-807daa2b565b?auto=format&fit=crop&q=80&w=800',
  ),
  Product(
    id: 5,
    name: 'مناديل مبللة برنس بيبي',
    category: 'مناديل',
    description:
        'مناديل مبللة ناعمة وآمنة، خالية من الكحول ومناسبة لبشرة الأطفال الحساسة.',
    features: ['خالية من الكحول', 'نعومة فائقة', 'ترطيب للبشرة'],
    color: AppColors.babyBlue,
    rating: 4.8,
    price: 2500,
    badge: 'جديد',
    image:
        'https://images.unsplash.com/photo-1563212693-0248873752e2?auto=format&fit=crop&q=80&w=800',
  ),
  Product(
    id: 6,
    name: 'كريم برنس للحبيبات',
    category: 'العناية بالبشرة',
    description: 'كريم وقائي فعال يحمي بشرة طفلك من التهيج ويحافظ على رطوبتها.',
    features: ['حماية من التهيج', 'ترطيب عميق', 'آمن يومياً'],
    color: AppColors.primaryPink,
    rating: 4.9,
    price: 3500,
    image:
        'https://images.unsplash.com/photo-1614859324967-bdf471bba561?auto=format&fit=crop&q=80&w=800',
  ),
  Product(
    id: 7,
    name: 'حفاضات برنس - مقاس 2',
    category: 'حفاضات',
    size: '2',
    description: 'حفاضات برنس للأطفال 3-6 كجم، إمتصاص فائق ونعومة لا تضاهى.',
    features: ['إمتصاص فائق', 'محيط خصر مرن', 'حماية من التسريب'],
    color: AppColors.softGreen,
    rating: 4.8,
    price: 5000,
    image:
        'https://images.unsplash.com/photo-1622290291468-a28f7a7dc6a8?auto=format&fit=crop&q=80&w=800',
  ),
  Product(
    id: 8,
    name: 'حفاضات برنس - مقاس 6',
    category: 'حفاضات',
    size: '6',
    description:
        'حفاضات برنس مقاس كبير 16+ كجم، توفر أقصى درجات الراحة والحماية.',
    features: ['حماية قصوى', 'جوانب مرنة جداً', 'إمتصاص كثيف'],
    color: AppColors.babyBlue,
    rating: 4.8,
    price: 7000,
    image:
        'https://images.unsplash.com/photo-1544126592-807daa2b565b?auto=format&fit=crop&q=80&w=800',
  ),
];

final List<String> productCategories = [
  'الكل',
  'حفاضات',
  'مناديل',
  'العناية بالبشرة',
];
final List<String> productSizes = ['الكل', '1', '2', '3', '4', '5', '6'];
