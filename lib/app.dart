import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prince_baby_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'theme/app_theme.dart';
import 'widgets/layout/app_scaffold.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/size_guide_screen.dart';
import 'screens/tips_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/blog_screen.dart';
import 'screens/not_found_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/products',
          builder: (context, state) => const ProductsScreen(),
        ),
        GoRoute(
          path: '/size-guide',
          builder: (context, state) => const SizeGuideScreen(),
        ),
        GoRoute(path: '/tips', builder: (context, state) => const TipsScreen()),
        GoRoute(path: '/faq', builder: (context, state) => const FaqScreen()),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactScreen(),
        ),
        GoRoute(path: '/blog', builder: (context, state) => const BlogScreen()),
      ],
    ),
  ],
);

class PrinceBabyApp extends StatelessWidget {
  const PrinceBabyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام context.watch بدلاً من Provider.of لتحديد إعادة البناء بدقة
    final themeMode = context.watch<ThemeProvider>().themeMode;
    final locale = context.watch<LocaleProvider>().locale;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          title: 'Prince Baby',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeMode,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar'), Locale('en')],
          routerConfig: _router,
        );
      },
    );
  }
}
