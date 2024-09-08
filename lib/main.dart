import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/theme_provider.dart';
import 'package:todo/splash_screen.dart';
import 'firebase_options.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', ''), Locale('ar', '')],
      path: 'assets/translations', // Translations path
      fallbackLocale: Locale('en', ''),

      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {



    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],

      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, ThemeProvider themeProvider, Widget? child) {
          return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          routes: {
          HomeScreen.routeName:(context)=>HomeScreen(),
          SplashScreen.routeName:(context)=>SplashScreen(),

          },


          );
        }
      ),
    );
  }
}


