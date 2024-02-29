import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_store_ui/routes.dart';
import 'package:fresh_store_ui/screens/tabbar/tabbar.dart';
import 'package:fresh_store_ui/theme.dart';
import 'package:easy_localization/easy_localization.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translation', // <-- change the path of the translation files
      fallbackLocale: Locale('ar'),
      child: FreshBuyerApp(),
    ),
  );
}

class FreshBuyerApp extends StatelessWidget {
  FreshBuyerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale('ar'));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: 'Fresh-Buyer',
      theme: appTheme(),
      routes: routes,
      locale: context.locale,
      home: SafeArea(child: FRTabbarScreen()),
    );
  }
}
