import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// خدمة مركزية لتحميل ملفات JSON من data_storage.
///
/// تعتمد على [rootBundle] لقراءة الملفات المُعلنة في pubspec.yaml
/// ضمن مجلد data_storage/ المُدار عبر Git Storage.
///
/// ### الأهداف:
/// - فصل طبقة البيانات عن منطق العرض (Separation of Concerns)
/// - تمكين التحكم بالبيانات عبر Git بشكل مستقل
/// - توفير طبقة تخزين مؤقت في الذاكرة (In-Memory Cache)
/// - دعم التحديث الديناميكي للبيانات
class GitStorageService {
  // Singleton pattern لضمان مثيل واحد فقط
  static final GitStorageService _instance = GitStorageService._internal();
  factory GitStorageService() => _instance;
  GitStorageService._internal();

  /// ذاكرة تخزين مؤقت للبيانات المحملة
  final Map<String, dynamic> _cache = {};

  /// تتبع إصدار البيانات المحملة
  final Map<String, String> _loadedVersions = {};

  /// تحميل ملف JSON واحد مع التخزين المؤقت
  ///
  /// [path] المسار النسبي داخل data_storage/
  /// [forceReload] لتجاهل الكاش وإعادة التحميل
  ///
  /// يُرجع Map<String, dynamic> يمثل محتوى ملف JSON
  Future<Map<String, dynamic>> loadJsonFile(
    String path, {
    bool forceReload = false,
  }) async {
    if (!forceReload && _cache.containsKey(path)) {
      return _cache[path] as Map<String, dynamic>;
    }

    try {
      final jsonString = await rootBundle.loadString(path);
      final data = json.decode(jsonString) as Map<String, dynamic>;

      // تتبع الإصدار من metadata
      if (data.containsKey('_metadata')) {
        final metadata = data['_metadata'] as Map<String, dynamic>;
        _loadedVersions[path] = metadata['version']?.toString() ?? 'unknown';
      }

      _cache[path] = data;
      return data;
    } catch (e) {
      throw GitStorageException(
        'فشل تحميل ملف البيانات: $path',
        originalError: e,
      );
    }
  }

  /// تحميل قائمة من عناصر JSON
  Future<List<dynamic>> loadJsonList(String path, String listKey) async {
    final data = await loadJsonFile(path);
    if (!data.containsKey(listKey)) {
      throw GitStorageException('المفتاح "$listKey" غير موجود في $path');
    }
    return data[listKey] as List<dynamic>;
  }

  /// الحصول على إصدار البيانات المحملة
  String? getLoadedVersion(String path) => _loadedVersions[path];

  /// مسح الكاش لملف معين أو لجميع الملفات
  void clearCache([String? path]) {
    if (path != null) {
      _cache.remove(path);
      _loadedVersions.remove(path);
    } else {
      _cache.clear();
      _loadedVersions.clear();
    }
  }

  /// التحقق من أن ملف بيانات محمل في الكاش
  bool isCached(String path) => _cache.containsKey(path);

  /// الحصول على جميع إصدارات البيانات المحملة (للتشخيص)
  Map<String, String> get loadedVersions => Map.unmodifiable(_loadedVersions);
}

/// استثناء مخصص لأخطاء Git Storage
class GitStorageException implements Exception {
  final String message;
  final Object? originalError;

  GitStorageException(this.message, {this.originalError});

  @override
  String toString() =>
      'GitStorageException: $message${originalError != null ? ' ($originalError)' : ''}';
}
