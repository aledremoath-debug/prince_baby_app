import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/git_storage_service.dart';

/// مسارات ملفات البيانات في Git Storage
class DataPaths {
  static const String products = 'data_storage/products/products.json';
  static const String blog = 'data_storage/blog/blog_posts.json';
  static const String faq = 'data_storage/faq/faq.json';
  static const String offers = 'data_storage/offers/offers.json';
  static const String partners = 'data_storage/partners/partners.json';
  static const String tips = 'data_storage/tips/tips.json';
  static const String config = 'data_storage/config/app_config.json';
}

/// خريطة لتحويل أسماء الألوان النصية إلى كائنات Color
Color _resolveColor(String? colorKey) {
  switch (colorKey) {
    case 'primaryPink':
      return AppColors.primaryPink;
    case 'babyBlue':
      return AppColors.babyBlue;
    case 'softGreen':
      return AppColors.softGreen;
    case 'coralRed':
      return AppColors.coralRed;
    default:
      return AppColors.babyBlue;
  }
}

/// خريطة لتحويل أسماء الأيقونات النصية إلى كائنات IconData
IconData _resolveIcon(String? iconName) {
  switch (iconName) {
    case 'child_care':
      return Icons.child_care;
    case 'newspaper':
      return Icons.newspaper;
    case 'access_time':
      return Icons.access_time;
    case 'card_giftcard':
      return Icons.card_giftcard;
    case 'bolt':
      return Icons.bolt;
    case 'percent':
      return Icons.percent;
    case 'shield':
      return Icons.shield;
    case 'water_drop':
      return Icons.water_drop;
    case 'wb_sunny':
      return Icons.wb_sunny;
    default:
      return Icons.info;
  }
}

// ─────────────────────────────────────────────
//  مُحمّل بيانات المنتجات
// ─────────────────────────────────────────────

/// يحمل بيانات المنتجات من Git Storage ويحولها
/// إلى كائنات Product الموجودة في products_data.dart
class ProductsLoader {
  static Future<Map<String, dynamic>> loadAll() async {
    final service = GitStorageService();
    final data = await service.loadJsonFile(DataPaths.products);

    final products = (data['products'] as List<dynamic>).map((json) {
      final map = json as Map<String, dynamic>;
      return {
        'id': map['id'],
        'name': map['name'],
        'category': map['category'],
        'size': map['size'],
        'description': map['description'],
        'features': List<String>.from(map['features']),
        'color': _resolveColor(map['colorKey']),
        'rating': (map['rating'] as num).toDouble(),
        'price': (map['price'] as num).toDouble(),
        'badge': map['badge'],
        'image': map['image'],
      };
    }).toList();

    return {
      'products': products,
      'categories': List<String>.from(data['categories']),
      'sizes': List<String>.from(data['sizes']),
    };
  }
}

// ─────────────────────────────────────────────
//  مُحمّل بيانات المدونة
// ─────────────────────────────────────────────

class BlogLoader {
  static Future<Map<String, dynamic>> loadAll() async {
    final service = GitStorageService();
    final data = await service.loadJsonFile(DataPaths.blog);

    final posts = (data['posts'] as List<dynamic>).map((json) {
      final map = json as Map<String, dynamic>;
      return {
        'id': map['id'],
        'title': map['title'],
        'excerpt': map['excerpt'],
        'category': map['category'],
        'readTime': map['readTime'],
        'date': map['date'],
        'color': _resolveColor(map['colorKey']),
        'icon': _resolveIcon(map['iconName']),
        'image': map['image'],
        'content': List<String>.from(map['content']),
      };
    }).toList();

    return {
      'posts': posts,
      'categories': List<String>.from(data['categories']),
    };
  }
}

// ─────────────────────────────────────────────
//  مُحمّل بيانات الأسئلة الشائعة
// ─────────────────────────────────────────────

class FaqLoader {
  static Future<Map<String, dynamic>> loadAll() async {
    final service = GitStorageService();
    final data = await service.loadJsonFile(DataPaths.faq);

    final faqs = (data['faqs'] as List<dynamic>).map((json) {
      final map = json as Map<String, dynamic>;
      return {
        'question': map['question'],
        'answer': map['answer'],
        'category': map['category'],
      };
    }).toList();

    return {'faqs': faqs, 'categories': List<String>.from(data['categories'])};
  }
}

// ─────────────────────────────────────────────
//  مُحمّل بيانات العروض
// ─────────────────────────────────────────────

class OffersLoader {
  static Future<List<Map<String, dynamic>>> loadAll() async {
    final service = GitStorageService();
    final data = await service.loadJsonFile(DataPaths.offers);

    return (data['offers'] as List<dynamic>).map((json) {
      final map = json as Map<String, dynamic>;
      return {
        'id': map['id'],
        'title': map['title'],
        'description': map['description'],
        'originalPrice': (map['originalPrice'] as num).toDouble(),
        'discountPrice': (map['discountPrice'] as num).toDouble(),
        'discountPercent': map['discountPercent'],
        'color': _resolveColor(map['colorKey']),
        'icon': _resolveIcon(map['iconName']),
        'durationDays': map['durationDays'],
      };
    }).toList();
  }
}

// ─────────────────────────────────────────────
//  مُحمّل بيانات الشركاء
// ─────────────────────────────────────────────

class PartnersLoader {
  static Future<Map<String, dynamic>> loadAll() async {
    final service = GitStorageService();
    final data = await service.loadJsonFile(DataPaths.partners);

    final partners = (data['partners'] as List<dynamic>).map((json) {
      final map = json as Map<String, dynamic>;
      return {'name': map['name'], 'initials': map['initials']};
    }).toList();

    final sizeGuide = (data['sizeGuide'] as List<dynamic>).map((json) {
      final map = json as Map<String, dynamic>;
      return {
        'size': map['size'],
        'label': map['label'],
        'weight': map['weight'],
        'minWeight': (map['minWeight'] as num).toDouble(),
        'maxWeight': (map['maxWeight'] as num).toDouble(),
        'count': map['count'],
        'price': map['price'],
        'ageRange': map['ageRange'],
        'emoji': map['emoji'],
      };
    }).toList();

    return {'partners': partners, 'sizeGuide': sizeGuide};
  }
}

// ─────────────────────────────────────────────
//  مُحمّل بيانات النصائح
// ─────────────────────────────────────────────

class TipsLoader {
  static Future<List<Map<String, dynamic>>> loadAll() async {
    final service = GitStorageService();
    final data = await service.loadJsonFile(DataPaths.tips);

    return (data['tips'] as List<dynamic>).map((json) {
      final map = json as Map<String, dynamic>;
      return {
        'icon': _resolveIcon(map['iconName']),
        'title': map['title'],
        'description': map['description'],
        'reasoning': map['reasoning'],
        'routineTime': map['routineTime'],
        'color': _resolveColor(map['colorKey']),
      };
    }).toList();
  }
}

// ─────────────────────────────────────────────
//  مُحمّل إعدادات التطبيق
// ─────────────────────────────────────────────

class AppConfigLoader {
  static Future<Map<String, dynamic>> load() async {
    final service = GitStorageService();
    return service.loadJsonFile(DataPaths.config);
  }

  /// التحقق من تفعيل ميزة معينة
  static Future<bool> isFeatureEnabled(String featureName) async {
    final config = await load();
    final features = config['features'] as Map<String, dynamic>?;
    return features?[featureName] == true;
  }
}
