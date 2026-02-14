// ignore_for_file: avoid_print
/// سكريبت التحقق من صحة بيانات Git Storage
///
/// يُستخدم كـ pre-commit hook أو يدوياً للتحقق من:
/// - صحة صيغة JSON
/// - وجود الحقول المطلوبة
/// - تكامل البيانات (مثل عدم تكرار IDs)
/// - وجود metadata في كل ملف
///
/// الاستخدام:
///   dart run scripts/validate_data.dart
library;

import 'dart:convert';
import 'dart:io';

// ─── ألوان الطباعة في الطرفية ────────────────────
const String _green = '\x1B[32m';
const String _red = '\x1B[31m';
const String _yellow = '\x1B[33m';
const String _reset = '\x1B[0m';

void _printSuccess(String msg) => print('$_green✓$_reset $msg');
void _printError(String msg) => print('$_red✗$_reset $msg');
void _printWarning(String msg) => print('$_yellow⚠$_reset $msg');

void main() async {
  print('');
  print('═══════════════════════════════════════════════');
  print(' Git Storage Data Validator');
  print(' التحقق من صحة بيانات التخزين');
  print('═══════════════════════════════════════════════');
  print('');

  int errors = 0;
  int warnings = 0;

  // ─── 1. التحقق من وجود الملفات الأساسية ─────────
  print('📁 التحقق من وجود الملفات...');
  final requiredFiles = [
    'data_storage/products/products.json',
    'data_storage/blog/blog_posts.json',
    'data_storage/faq/faq.json',
    'data_storage/offers/offers.json',
    'data_storage/partners/partners.json',
    'data_storage/tips/tips.json',
    'data_storage/config/app_config.json',
    'data_storage/CHANGELOG.json',
  ];

  for (final filePath in requiredFiles) {
    final file = File(filePath);
    if (await file.exists()) {
      _printSuccess('موجود: $filePath');
    } else {
      _printError('مفقود: $filePath');
      errors++;
    }
  }
  print('');

  // ─── 2. التحقق من صحة صيغة JSON ─────────────────
  print('🔍 التحقق من صحة صيغة JSON...');
  for (final filePath in requiredFiles) {
    final file = File(filePath);
    if (!await file.exists()) continue;

    try {
      final content = await file.readAsString();
      final data = json.decode(content);

      if (data is! Map<String, dynamic>) {
        _printError('$filePath: الجذر يجب أن يكون Object');
        errors++;
        continue;
      }

      _printSuccess('صيغة صحيحة: $filePath');

      // التحقق من وجود metadata
      if (!data.containsKey('_metadata')) {
        _printWarning('$filePath: لا يحتوي على _metadata');
        warnings++;
      } else {
        final metadata = data['_metadata'] as Map<String, dynamic>;
        if (!metadata.containsKey('version')) {
          _printWarning('$filePath: _metadata لا يحتوي على version');
          warnings++;
        }
        if (!metadata.containsKey('lastUpdated')) {
          _printWarning('$filePath: _metadata لا يحتوي على lastUpdated');
          warnings++;
        }
      }
    } on FormatException catch (e) {
      _printError('$filePath: خطأ في JSON - ${e.message}');
      errors++;
    } catch (e) {
      _printError('$filePath: خطأ غير متوقع - $e');
      errors++;
    }
  }
  print('');

  // ─── 3. التحقق من تكامل المنتجات ─────────────────
  print('📦 التحقق من تكامل بيانات المنتجات...');
  try {
    final productsFile = File('data_storage/products/products.json');
    if (await productsFile.exists()) {
      final data =
          json.decode(await productsFile.readAsString())
              as Map<String, dynamic>;
      final products = data['products'] as List<dynamic>? ?? [];

      // التحقق من تكرار IDs
      final ids = <int>{};
      for (final product in products) {
        final id = (product as Map<String, dynamic>)['id'] as int;
        if (ids.contains(id)) {
          _printError('المنتج ID=$id مكرر!');
          errors++;
        }
        ids.add(id);
      }

      // التحقق من الحقول المطلوبة
      for (final product in products) {
        final p = product as Map<String, dynamic>;
        final requiredFields = [
          'id',
          'name',
          'category',
          'description',
          'features',
          'colorKey',
          'rating',
          'price',
          'image',
        ];
        for (final field in requiredFields) {
          if (!p.containsKey(field) || p[field] == null) {
            _printError(
              'المنتج "${p['name'] ?? p['id']}": الحقل "$field" مفقود',
            );
            errors++;
          }
        }
      }

      if (errors == 0) {
        _printSuccess('بيانات المنتجات صحيحة (${products.length} منتج)');
      }
    }
  } catch (e) {
    _printError('خطأ في التحقق من المنتجات: $e');
    errors++;
  }
  print('');

  // ─── 4. التحقق من تكامل المدونة ──────────────────
  print('📝 التحقق من تكامل بيانات المدونة...');
  try {
    final blogFile = File('data_storage/blog/blog_posts.json');
    if (await blogFile.exists()) {
      final data =
          json.decode(await blogFile.readAsString()) as Map<String, dynamic>;
      final posts = data['posts'] as List<dynamic>? ?? [];

      final ids = <int>{};
      for (final post in posts) {
        final id = (post as Map<String, dynamic>)['id'] as int;
        if (ids.contains(id)) {
          _printError('المقالة ID=$id مكررة!');
          errors++;
        }
        ids.add(id);
      }

      _printSuccess('بيانات المدونة صحيحة (${posts.length} مقالة)');
    }
  } catch (e) {
    _printError('خطأ في التحقق من المدونة: $e');
    errors++;
  }
  print('');

  // ─── 5. التحقق من ملف الإعدادات ──────────────────
  print('⚙️  التحقق من إعدادات التطبيق...');
  try {
    final configFile = File('data_storage/config/app_config.json');
    if (await configFile.exists()) {
      final data =
          json.decode(await configFile.readAsString()) as Map<String, dynamic>;

      final requiredSections = ['app', 'features', 'storage', 'theme'];
      for (final section in requiredSections) {
        if (data.containsKey(section)) {
          _printSuccess('قسم "$section" موجود');
        } else {
          _printError('قسم "$section" مفقود من الإعدادات');
          errors++;
        }
      }
    }
  } catch (e) {
    _printError('خطأ في التحقق من الإعدادات: $e');
    errors++;
  }

  // ─── النتائج النهائية ──────────────────────────────
  print('');
  print('═══════════════════════════════════════════════');
  if (errors == 0) {
    print('$_green 🎉 جميع الفحوصات ناجحة!$_reset');
  } else {
    print('$_red ❌ وُجدت $errors أخطاء و $warnings تحذيرات$_reset');
  }
  print('═══════════════════════════════════════════════');
  print('');

  exit(errors > 0 ? 1 : 0);
}
