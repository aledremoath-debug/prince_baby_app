import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'برنس بيبي'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get navHome;

  /// No description provided for @navAbout.
  ///
  /// In ar, this message translates to:
  /// **'من نحن'**
  String get navAbout;

  /// No description provided for @navProducts.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات'**
  String get navProducts;

  /// No description provided for @navTips.
  ///
  /// In ar, this message translates to:
  /// **'النصائح الطبية'**
  String get navTips;

  /// No description provided for @navFaq.
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة'**
  String get navFaq;

  /// No description provided for @navContact.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا'**
  String get navContact;

  /// No description provided for @navSizeGuide.
  ///
  /// In ar, this message translates to:
  /// **'دليل المقاسات'**
  String get navSizeGuide;

  /// No description provided for @navBlog.
  ///
  /// In ar, this message translates to:
  /// **'المدونة'**
  String get navBlog;

  /// No description provided for @heroBadge.
  ///
  /// In ar, this message translates to:
  /// **'جودة عالية - راحة فائقة'**
  String get heroBadge;

  /// No description provided for @heroTitle.
  ///
  /// In ar, this message translates to:
  /// **'حفاضات برنس بيبي'**
  String get heroTitle;

  /// No description provided for @heroSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'راحة فائقة، حماية مثالية'**
  String get heroSubtitle;

  /// No description provided for @heroDesc.
  ///
  /// In ar, this message translates to:
  /// **'اكتشفوا تشكيلتنا الواسعة من الحفاضات والمناديل عالية الجودة المصممة خصيصاً لراحة طفلك وحماية بشرته الحساسة، بلمسة وطنية وجودة عالمية.'**
  String get heroDesc;

  /// No description provided for @heroCtaProducts.
  ///
  /// In ar, this message translates to:
  /// **'اكتشف المنتجات'**
  String get heroCtaProducts;

  /// No description provided for @heroCtaContact.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا'**
  String get heroCtaContact;

  /// No description provided for @productsTitle.
  ///
  /// In ar, this message translates to:
  /// **'منتجاتنا'**
  String get productsTitle;

  /// No description provided for @productsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اكتشف تشكيلتنا الواسعة'**
  String get productsSubtitle;

  /// No description provided for @productsDesc.
  ///
  /// In ar, this message translates to:
  /// **'منتجات عالية الجودة مصممة خصيصاً لراحة طفلك وحماية بشرته'**
  String get productsDesc;

  /// No description provided for @filterAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get filterAll;

  /// No description provided for @filterDiapers.
  ///
  /// In ar, this message translates to:
  /// **'حفاضات'**
  String get filterDiapers;

  /// No description provided for @filterWipes.
  ///
  /// In ar, this message translates to:
  /// **'مناديل'**
  String get filterWipes;

  /// No description provided for @filterSkincare.
  ///
  /// In ar, this message translates to:
  /// **'العناية بالبشرة'**
  String get filterSkincare;

  /// No description provided for @details.
  ///
  /// In ar, this message translates to:
  /// **'التفاصيل'**
  String get details;

  /// No description provided for @addToCart.
  ///
  /// In ar, this message translates to:
  /// **'أضف للسلة'**
  String get addToCart;

  /// No description provided for @features.
  ///
  /// In ar, this message translates to:
  /// **'المميزات'**
  String get features;

  /// No description provided for @cartTitle.
  ///
  /// In ar, this message translates to:
  /// **'سلة التسوق'**
  String get cartTitle;

  /// No description provided for @cartEmpty.
  ///
  /// In ar, this message translates to:
  /// **'السلة فارغة'**
  String get cartEmpty;

  /// No description provided for @cartEmptyDesc.
  ///
  /// In ar, this message translates to:
  /// **'أضف بعض المنتجات لبدء التسوق'**
  String get cartEmptyDesc;

  /// No description provided for @cartTotal.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get cartTotal;

  /// No description provided for @checkout.
  ///
  /// In ar, this message translates to:
  /// **'إتمام الشراء'**
  String get checkout;

  /// No description provided for @continueShopping.
  ///
  /// In ar, this message translates to:
  /// **'مواصلة التسوق'**
  String get continueShopping;

  /// No description provided for @itemAdded.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة المنتج إلى السلة'**
  String get itemAdded;

  /// No description provided for @orderSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلبك بنجاح!'**
  String get orderSuccess;

  /// No description provided for @faqTitle.
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة'**
  String get faqTitle;

  /// No description provided for @faqSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'إجابات على استفساراتك'**
  String get faqSubtitle;

  /// No description provided for @contactTitle.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا'**
  String get contactTitle;

  /// No description provided for @contactSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'نحن هنا للمساعدة'**
  String get contactSubtitle;

  /// No description provided for @contactDesc.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا للاستفسارات أو الطلبات، فريقنا جاهز لمساعدتك'**
  String get contactDesc;

  /// No description provided for @formTitle.
  ///
  /// In ar, this message translates to:
  /// **'أرسل رسالتك'**
  String get formTitle;

  /// No description provided for @nameLabel.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get nameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get emailLabel;

  /// No description provided for @messageLabel.
  ///
  /// In ar, this message translates to:
  /// **'الرسالة'**
  String get messageLabel;

  /// No description provided for @sendMessage.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الرسالة'**
  String get sendMessage;

  /// No description provided for @sendSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم الإرسال بنجاح! سنتواصل معك في أقرب وقت'**
  String get sendSuccess;

  /// No description provided for @sizeGuideTitle.
  ///
  /// In ar, this message translates to:
  /// **'دليل المقاسات الذكي'**
  String get sizeGuideTitle;

  /// No description provided for @sizeGuideSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'حدد وزن طفلك وسنكشف لك عن المقاس المثالي فوراً'**
  String get sizeGuideSubtitle;

  /// No description provided for @recommendedSize.
  ///
  /// In ar, this message translates to:
  /// **'المقاس الموصى به'**
  String get recommendedSize;

  /// No description provided for @babyWeight.
  ///
  /// In ar, this message translates to:
  /// **'وزن الطفل الحالي'**
  String get babyWeight;

  /// No description provided for @kg.
  ///
  /// In ar, this message translates to:
  /// **'كجم'**
  String get kg;

  /// No description provided for @selectManually.
  ///
  /// In ar, this message translates to:
  /// **'أو اختر مقاسك يدوياً'**
  String get selectManually;

  /// No description provided for @aboutTitle.
  ///
  /// In ar, this message translates to:
  /// **'من نحن'**
  String get aboutTitle;

  /// No description provided for @aboutSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'قصة برنس بيبي'**
  String get aboutSubtitle;

  /// No description provided for @tipsTitle.
  ///
  /// In ar, this message translates to:
  /// **'نصائح طبية'**
  String get tipsTitle;

  /// No description provided for @tipsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'الدليل الطبي للعناية ببشرة ملكنا الصغير'**
  String get tipsSubtitle;

  /// No description provided for @blogTitle.
  ///
  /// In ar, this message translates to:
  /// **'المدونة'**
  String get blogTitle;

  /// No description provided for @blogSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'نصائح ومقالات للأمهات'**
  String get blogSubtitle;

  /// No description provided for @readMore.
  ///
  /// In ar, this message translates to:
  /// **'اقرأ المزيد'**
  String get readMore;

  /// No description provided for @searchArticles.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في المقالات...'**
  String get searchArticles;

  /// No description provided for @searchFaq.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في الأسئلة...'**
  String get searchFaq;

  /// No description provided for @showFilters.
  ///
  /// In ar, this message translates to:
  /// **'عرض الفلاتر'**
  String get showFilters;

  /// No description provided for @hideFilters.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء الفلاتر'**
  String get hideFilters;

  /// No description provided for @size.
  ///
  /// In ar, this message translates to:
  /// **'مقاس'**
  String get size;

  /// No description provided for @currency.
  ///
  /// In ar, this message translates to:
  /// **'ر.ي'**
  String get currency;

  /// No description provided for @yearsLeading.
  ///
  /// In ar, this message translates to:
  /// **'سنة ريادة'**
  String get yearsLeading;

  /// No description provided for @happyConsumers.
  ///
  /// In ar, this message translates to:
  /// **'مستهلك سعيد'**
  String get happyConsumers;

  /// No description provided for @nationalProducts.
  ///
  /// In ar, this message translates to:
  /// **'منتج وطني'**
  String get nationalProducts;

  /// No description provided for @footerRights.
  ///
  /// In ar, this message translates to:
  /// **'جميع الحقوق محفوظة'**
  String get footerRights;

  /// No description provided for @quickLinks.
  ///
  /// In ar, this message translates to:
  /// **'روابط سريعة'**
  String get quickLinks;

  /// No description provided for @contactInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومات التواصل'**
  String get contactInfo;

  /// No description provided for @newsletter.
  ///
  /// In ar, this message translates to:
  /// **'النشرة البريدية'**
  String get newsletter;

  /// No description provided for @newsletterDesc.
  ///
  /// In ar, this message translates to:
  /// **'اشترك للحصول على أحدث العروض والأخبار'**
  String get newsletterDesc;

  /// No description provided for @subscribe.
  ///
  /// In ar, this message translates to:
  /// **'اشترك'**
  String get subscribe;

  /// No description provided for @emailPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'بريدك الإلكتروني'**
  String get emailPlaceholder;

  /// No description provided for @privacyPolicy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الخصوصية'**
  String get privacyPolicy;

  /// No description provided for @terms.
  ///
  /// In ar, this message translates to:
  /// **'الشروط والأحكام'**
  String get terms;

  /// No description provided for @limitedOffers.
  ///
  /// In ar, this message translates to:
  /// **'عروض لفترة محدودة!'**
  String get limitedOffers;

  /// No description provided for @exclusiveOffers.
  ///
  /// In ar, this message translates to:
  /// **'عروض حصرية'**
  String get exclusiveOffers;

  /// No description provided for @offersDesc.
  ///
  /// In ar, this message translates to:
  /// **'استفيدي من عروضنا المميزة قبل انتهاء الوقت!'**
  String get offersDesc;

  /// No description provided for @orderNow.
  ///
  /// In ar, this message translates to:
  /// **'اطلب الآن'**
  String get orderNow;

  /// No description provided for @offerEnds.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي العرض خلال:'**
  String get offerEnds;

  /// No description provided for @day.
  ///
  /// In ar, this message translates to:
  /// **'يوم'**
  String get day;

  /// No description provided for @hour.
  ///
  /// In ar, this message translates to:
  /// **'ساعة'**
  String get hour;

  /// No description provided for @minute.
  ///
  /// In ar, this message translates to:
  /// **'دقيقة'**
  String get minute;

  /// No description provided for @second.
  ///
  /// In ar, this message translates to:
  /// **'ثانية'**
  String get second;

  /// No description provided for @partnersTitle.
  ///
  /// In ar, this message translates to:
  /// **'متوفر لدى الجميع'**
  String get partnersTitle;

  /// No description provided for @partnersSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'شركاؤنا'**
  String get partnersSubtitle;

  /// No description provided for @partnersDesc.
  ///
  /// In ar, this message translates to:
  /// **'منتجاتنا متوفرة في أشهر المتاجر والصيدليات'**
  String get partnersDesc;

  /// No description provided for @howItWorksTitle.
  ///
  /// In ar, this message translates to:
  /// **'كيف تعمل حفاضاتنا؟'**
  String get howItWorksTitle;

  /// No description provided for @howItWorksSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'التقنية'**
  String get howItWorksSubtitle;

  /// No description provided for @howItWorksDesc.
  ///
  /// In ar, this message translates to:
  /// **'5 طبقات متطورة تعمل معاً لتوفير حماية مثالية تدوم حتى 12 ساعة'**
  String get howItWorksDesc;

  /// No description provided for @whatsappChat.
  ///
  /// In ar, this message translates to:
  /// **'بدء المحادثة'**
  String get whatsappChat;

  /// No description provided for @whatsappGreeting.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً 👋\nكيف يمكننا مساعدتك؟ نرد خلال 5 دقائق!'**
  String get whatsappGreeting;

  /// No description provided for @onlineNow.
  ///
  /// In ar, this message translates to:
  /// **'متصل الآن'**
  String get onlineNow;

  /// No description provided for @fillAllFields.
  ///
  /// In ar, this message translates to:
  /// **'يرجى ملء جميع الحقول'**
  String get fillAllFields;

  /// No description provided for @helpful.
  ///
  /// In ar, this message translates to:
  /// **'نعم'**
  String get helpful;

  /// No description provided for @notHelpful.
  ///
  /// In ar, this message translates to:
  /// **'لا'**
  String get notHelpful;

  /// No description provided for @wasHelpful.
  ///
  /// In ar, this message translates to:
  /// **'هل كانت الإجابة مفيدة؟'**
  String get wasHelpful;

  /// No description provided for @noResults.
  ///
  /// In ar, this message translates to:
  /// **'لم نجد نتائج مطابقة لبحثك'**
  String get noResults;

  /// No description provided for @resetSearch.
  ///
  /// In ar, this message translates to:
  /// **'إعادة ضبط البحث'**
  String get resetSearch;

  /// No description provided for @questionsFound.
  ///
  /// In ar, this message translates to:
  /// **'سؤال تم العثور عليه'**
  String get questionsFound;

  /// No description provided for @notFoundQuestion.
  ///
  /// In ar, this message translates to:
  /// **'لم تجد إجابة لسؤالك؟'**
  String get notFoundQuestion;

  /// No description provided for @productsAvailable.
  ///
  /// In ar, this message translates to:
  /// **'منتج متوفر'**
  String get productsAvailable;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الفاتح'**
  String get lightMode;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @namePlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسمك'**
  String get namePlaceholder;

  /// No description provided for @emailInputPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني'**
  String get emailInputPlaceholder;

  /// No description provided for @messagePlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'اكتب رسالتك هنا...'**
  String get messagePlaceholder;

  /// No description provided for @address.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get address;

  /// No description provided for @phone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phone;

  /// No description provided for @workingHours.
  ///
  /// In ar, this message translates to:
  /// **'ساعات العمل'**
  String get workingHours;

  /// No description provided for @expertTip.
  ///
  /// In ar, this message translates to:
  /// **'نصيحة الخبراء: إذا كان وزن طفلك على الحدود الفاصلة بين مقاسين، ننصحك دائماً باختيار المقاس الأكبر لضمان أقصى درجات الراحة وحرية الحركة لطفلك.'**
  String get expertTip;

  /// No description provided for @diaperCount.
  ///
  /// In ar, this message translates to:
  /// **'حفاضة'**
  String get diaperCount;

  /// No description provided for @layer.
  ///
  /// In ar, this message translates to:
  /// **'الطبقة'**
  String get layer;

  /// No description provided for @medicalExplanation.
  ///
  /// In ar, this message translates to:
  /// **'التفسير الطبي'**
  String get medicalExplanation;

  /// No description provided for @verifiedByExperts.
  ///
  /// In ar, this message translates to:
  /// **'موثق طبياً'**
  String get verifiedByExperts;

  /// No description provided for @dailyRoutine.
  ///
  /// In ar, this message translates to:
  /// **'الروتين اليومي المقترح'**
  String get dailyRoutine;

  /// No description provided for @hide.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء'**
  String get hide;

  /// No description provided for @bestSeller.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر مبيعاً'**
  String get bestSeller;

  /// No description provided for @newProduct.
  ///
  /// In ar, this message translates to:
  /// **'جديد'**
  String get newProduct;

  /// No description provided for @savings.
  ///
  /// In ar, this message translates to:
  /// **'توفير'**
  String get savings;

  /// No description provided for @globalQuality.
  ///
  /// In ar, this message translates to:
  /// **'جودة عالمية'**
  String get globalQuality;

  /// No description provided for @cottonQuality.
  ///
  /// In ar, this message translates to:
  /// **'جودة قطنية'**
  String get cottonQuality;

  /// No description provided for @cottonQualityDesc.
  ///
  /// In ar, this message translates to:
  /// **'نضمن لك أفضل حماية وراحة لبشرة طفلك الحساسة طوال اليوم.'**
  String get cottonQualityDesc;

  /// No description provided for @notFoundTitle.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة غير موجودة'**
  String get notFoundTitle;

  /// No description provided for @notFoundDesc.
  ///
  /// In ar, this message translates to:
  /// **'عذراً، لم نتمكن من العثور على الصفحة المطلوبة'**
  String get notFoundDesc;

  /// No description provided for @goHome.
  ///
  /// In ar, this message translates to:
  /// **'العودة للرئيسية'**
  String get goHome;

  /// No description provided for @notificationText.
  ///
  /// In ar, this message translates to:
  /// **'🎉 خصم 20% على جميع المنتجات لفترة محدودة!'**
  String get notificationText;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
