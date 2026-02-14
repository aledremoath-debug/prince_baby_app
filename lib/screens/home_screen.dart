import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prince_baby_app/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/cart_provider.dart';
import '../theme/app_colors.dart';
import '../data/products_data.dart';
import '../data/offers_data.dart';
import '../data/partners_data.dart';
import 'dart:async';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام CustomScrollView مع Slivers للتحميل الكسول
    // بدلاً من SingleChildScrollView الذي يبني كل شيء دفعة واحدة
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: RepaintBoundary(child: _HeroSection())),
        const SliverToBoxAdapter(
          child: RepaintBoundary(child: _AboutSection()),
        ),
        const SliverToBoxAdapter(
          child: RepaintBoundary(child: _HowItWorksSection()),
        ),
        const SliverToBoxAdapter(
          child: RepaintBoundary(child: _ProductsPreview()),
        ),
        const SliverToBoxAdapter(
          child: RepaintBoundary(child: _OffersSection()),
        ),
        const SliverToBoxAdapter(
          child: RepaintBoundary(child: _PartnersSection()),
        ),
        const SliverToBoxAdapter(
          child: RepaintBoundary(child: _FooterSection()),
        ),
      ],
    );
  }
}

// ======================== HERO SECTION ========================
class _HeroSection extends StatefulWidget {
  const _HeroSection();
  @override
  State<_HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<_HeroSection> {
  int _selectedSize = 3;
  int _currentImageIndex = 0;
  late Timer _imageTimer;

  // استخدام const list لتجنب إعادة إنشاء القائمة
  static const List<String> _heroImages = [
    'https://images.unsplash.com/photo-1519689680058-324335c77eba?auto=format&fit=crop&q=80&w=800',
    'https://images.unsplash.com/photo-1622290291468-a28f7a7dc6a8?auto=format&fit=crop&q=80&w=800',
    'https://images.unsplash.com/photo-1555252333-9f8e92e65df9?auto=format&fit=crop&q=80&w=800',
  ];

  @override
  void initState() {
    super.initState();
    _imageTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(
          () => _currentImageIndex =
              (_currentImageIndex + 1) % _heroImages.length,
        );
      }
    });
  }

  @override
  void dispose() {
    _imageTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryPink.withValues(alpha: 0.08),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        children: [
          // Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primaryPink.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              l.heroBadge,
              style: TextStyle(
                color: AppColors.primaryPink,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),
          const SizedBox(height: 20),

          // Product image carousel - تحسين حجم الصورة في الذاكرة
          AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                child: ClipRRect(
                  key: ValueKey(_currentImageIndex),
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: _heroImages[_currentImageIndex],
                    height: 240.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    memCacheWidth: 800, // حد أقصى لعرض الصورة في الذاكرة
                    memCacheHeight: 480,
                    placeholder: (_, __) => Container(
                      height: 240.h,
                      color: AppColors.primaryPink.withValues(alpha: 0.1),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      height: 240.h,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 800.ms)
              .scale(begin: const Offset(0.9, 0.9)),

          // Dots indicator
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentImageIndex == i ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: _currentImageIndex == i
                        ? AppColors.primaryPink
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            l.heroTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),
          const SizedBox(height: 8),
          Text(
            l.heroSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryPink.withValues(alpha: 0.8),
            ),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l.heroDesc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).textTheme.bodySmall?.color,
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(delay: 600.ms),
          const SizedBox(height: 24),

          // Size selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (i) {
              final size = i + 1;
              final isSelected = _selectedSize == size;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedSize = size),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryPink
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryPink
                            : Colors.grey[300]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        '$size',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : null,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2),

          const SizedBox(height: 24),
          // Feature icons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _featureIcon(
                Icons.water_drop_outlined,
                AppColors.babyBlue,
                'امتصاص فائق',
              ),
              _featureIcon(
                Icons.shield_outlined,
                AppColors.softGreen,
                'حماية كاملة',
              ),
              _featureIcon(
                Icons.favorite_outline,
                AppColors.primaryPink,
                'بشرة صحية',
              ),
              _featureIcon(
                Icons.eco_outlined,
                AppColors.softGreen,
                'صديق للبيئة',
              ),
            ],
          ).animate().fadeIn(delay: 1000.ms),
        ],
      ),
    );
  }

  Widget _featureIcon(IconData icon, Color color, String label) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(icon, color: color, size: 24.sp),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// ======================== ABOUT SECTION ========================
class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _sectionHeader(l.aboutTitle, l.aboutSubtitle),
          const SizedBox(height: 20),
          // Stats row
          Row(
            children: [
              _statCard('🏆', '10+', l.yearsLeading, AppColors.primaryPink),
              const SizedBox(width: 12),
              _statCard('😊', '50K+', l.happyConsumers, AppColors.babyBlue),
              const SizedBox(width: 12),
              _statCard('🇾🇪', '15+', l.nationalProducts, AppColors.softGreen),
            ].map((w) => Expanded(child: w)).toList(),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
          const SizedBox(height: 20),
          // Feature cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.1,
            children: [
              _featureCard(
                Icons.verified,
                'جودة فائقة',
                'مصنوعة من أجود المواد المستوردة',
                AppColors.primaryPink,
              ),
              _featureCard(
                Icons.shield,
                'آمنة تماماً',
                'خالية من المواد الكيميائية الضارة',
                AppColors.babyBlue,
              ),
              _featureCard(
                Icons.local_shipping,
                'توصيل سريع',
                'شحن مجاني للطلبات الكبيرة',
                AppColors.softGreen,
              ),
              _featureCard(
                Icons.thumb_up,
                'رضا العملاء',
                'أكثر من 50 ألف عميل سعيد',
                AppColors.gold,
              ),
            ],
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _statCard(String emoji, String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Text(emoji, style: TextStyle(fontSize: 24.sp)),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            desc,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ======================== HOW IT WORKS SECTION ========================
class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection();

  // قائمة ثابتة لتجنب إعادة إنشائها في كل build
  static final List<Map<String, dynamic>> _layers = [
    {
      'title': 'الطبقة الخارجية المسامية',
      'desc': 'طبقة ناعمة تسمح بمرور الهواء وتمنع التسرب',
      'color': AppColors.babyBlue,
      'icon': Icons.air,
    },
    {
      'title': 'طبقة التوزيع',
      'desc': 'توزع السائل بالتساوي لامتصاص أسرع',
      'color': AppColors.softGreen,
      'icon': Icons.grid_view,
    },
    {
      'title': 'نواة الامتصاص الفائقة',
      'desc': 'تحول السائل إلى جل وتحتفظ به بعيداً عن البشرة',
      'color': AppColors.primaryPink,
      'icon': Icons.water_drop,
    },
    {
      'title': 'حواجز التسرب الجانبية',
      'desc': 'حواجز مرنة تمنع التسرب الجانبي',
      'color': AppColors.gold,
      'icon': Icons.security,
    },
    {
      'title': 'الطبقة الداخلية القطنية',
      'desc': 'ملمس قطني ناعم يلامس بشرة الطفل بلطف',
      'color': AppColors.coralRed,
      'icon': Icons.spa,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _sectionHeader(l.howItWorksTitle, l.howItWorksDesc),
          const SizedBox(height: 24),
          ..._layers.asMap().entries.map((entry) {
            final i = entry.key;
            final layer = entry.value;
            final color = layer['color'] as Color;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline
                  Column(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: color,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      if (i < 4)
                        Container(
                          width: 2,
                          height: 40,
                          color: color.withValues(alpha: 0.2),
                        ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  // Content
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: color.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            layer['icon'] as IconData,
                            color: color,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  layer['title'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  layer['desc'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: (200 * i).ms).slideX(begin: 0.2);
          }),
        ],
      ),
    );
  }
}

// ======================== PRODUCTS PREVIEW ========================
class _ProductsPreview extends StatelessWidget {
  const _ProductsPreview();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final products = allProducts.take(4).toList();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _sectionHeader(l.productsTitle, l.productsDesc),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.65,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return _ProductCard(product: p);
            },
          ).animate().fadeIn(delay: 200.ms),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image - تحسين حجم الذاكرة
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: product.image,
                height: 110.h,
                width: double.infinity,
                fit: BoxFit.cover,
                memCacheWidth: 400, // تقليل استهلاك الذاكرة
                memCacheHeight: 220,
                placeholder: (_, __) => Container(
                  height: 110.h,
                  color: product.color.withValues(alpha: 0.1),
                ),
                errorWidget: (_, __, ___) => Container(
                  height: 110.h,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
                ),
              ),
              if (product.badge != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: product.color,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      product.badge!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      Text(
                        ' ${product.rating}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(0)} ${l.currency}',
                        style: TextStyle(
                          color: AppColors.primaryPink,
                          fontWeight: FontWeight.w900,
                          fontSize: 13.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<CartProvider>().addItem(
                            id: product.id,
                            name: product.name,
                            price: product.price,
                            color: product.color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l.itemAdded),
                              backgroundColor: AppColors.primaryPink,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryPink,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================== OFFERS SECTION ========================
class _OffersSection extends StatelessWidget {
  const _OffersSection();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryPink.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          _sectionHeader(l.exclusiveOffers, l.offersDesc),
          const SizedBox(height: 20),
          ...allOffers.asMap().entries.map((entry) {
            final i = entry.key;
            final offer = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: offer.color.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: offer.color.withValues(alpha: 0.1),
                    blurRadius: 12.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: offer.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Icon(
                          offer.icon,
                          color: offer.color,
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              offer.description,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Text(
                        offer.originalPrice.toStringAsFixed(0),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${offer.discountPrice.toStringAsFixed(0)} ${l.currency}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: offer.color,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '-${offer.discountPercent}%',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // عزل عداد العد التنازلي في RepaintBoundary
                  RepaintBoundary(
                    child: _CountdownTimer(
                      duration: offer.duration,
                      color: offer.color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartProvider>().addItem(
                          id: offer.id,
                          name: offer.title,
                          price: offer.discountPrice,
                          color: offer.color,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l.itemAdded),
                            backgroundColor: offer.color,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: offer.color,
                      ),
                      child: Text(l.orderNow),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: (200 * i).ms).slideY(begin: 0.2);
          }),
        ],
      ),
    );
  }
}

// عداد العد التنازلي المعزول - يتحدث فقط هذا القسم عند كل ثانية
class _CountdownTimer extends StatefulWidget {
  final Duration duration;
  final Color color;
  const _CountdownTimer({required this.duration, required this.color});
  @override
  State<_CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<_CountdownTimer> {
  late DateTime _endTime;
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _endTime = DateTime.now().add(widget.duration);
    _remaining = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final r = _endTime.difference(DateTime.now());
      setState(() => _remaining = r.isNegative ? Duration.zero : r);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Row(
      children: [
        _timeBox(_remaining.inDays.toString(), l.day, widget.color),
        _timeBox(
          (_remaining.inHours % 24).toString().padLeft(2, '0'),
          l.hour,
          widget.color,
        ),
        _timeBox(
          (_remaining.inMinutes % 60).toString().padLeft(2, '0'),
          l.minute,
          widget.color,
        ),
        _timeBox(
          (_remaining.inSeconds % 60).toString().padLeft(2, '0'),
          l.second,
          widget.color,
        ),
      ],
    );
  }

  Widget _timeBox(String value, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================== PARTNERS SECTION ========================
class _PartnersSection extends StatelessWidget {
  const _PartnersSection();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _sectionHeader(l.partnersSubtitle, l.partnersDesc),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: allPartners.length,
            itemBuilder: (context, index) {
              final p = allPartners[index];
              return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primaryPink.withValues(
                            alpha: 0.1,
                          ),
                          child: Text(
                            p.initials,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryPink,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p.name,
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(delay: (100 * index).ms)
                  .scale(begin: const Offset(0.8, 0.8));
            },
          ),
        ],
      ),
    );
  }
}

// ======================== FOOTER SECTION ========================
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF0D1117)
          : const Color(0xFF1F2937),
      child: Column(
        children: [
          // Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('👶', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Text(
                l.appTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Contact info
          _footerInfoRow(
            Icons.location_on_outlined,
            'صنعاء - شارع الستين - بجوار مركز الأمل',
          ),
          _footerInfoRow(Icons.phone_outlined, '+967 736 499 765'),
          _footerInfoRow(Icons.email_outlined, 'info@princebaby.com'),
          const SizedBox(height: 20),
          // Social icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.facebook),
              _socialIcon(Icons.camera_alt_outlined),
              _socialIcon(Icons.alternate_email),
            ],
          ),
          const SizedBox(height: 20),
          // Newsletter
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  l.newsletter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l.newsletterDesc,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: l.emailPlaceholder,
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.4),
                            fontSize: 13,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                      child: Text(l.subscribe),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 12),
          Text(
            '© 2024 Prince Baby. ${l.footerRights}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryPink, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

// ======================== HELPERS ========================
Widget _sectionHeader(String title, String subtitle) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
        textAlign: TextAlign.center,
      ).animate().fadeIn().slideY(begin: 0.2),
      const SizedBox(height: 8),
      Text(
        subtitle,
        style: const TextStyle(fontSize: 13, color: Colors.grey),
        textAlign: TextAlign.center,
      ).animate().fadeIn(delay: 100.ms),
      const SizedBox(height: 4),
      Container(
        width: 50,
        height: 3,
        decoration: BoxDecoration(
          color: AppColors.primaryPink,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    ],
  );
}
