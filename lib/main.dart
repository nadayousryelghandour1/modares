import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/network/services/notification_service.dart';
import 'package:modares/features/splash/view.dart';
import 'package:modares/l10n/app_localizations.dart';
import 'package:modares/provider/lang_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();                    // أضيف السطر ده
  await NotificationService.requestAndroidPermission(); // وده

  runApp(
    ChangeNotifierProvider(create: (_) => localeProvider, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      locale: provider.locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
