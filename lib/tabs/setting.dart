import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings').tr(),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('language',style: TextStyle(fontSize: 25),).tr(),
            DropdownButton<Locale>(
              value: context.locale,
              items: [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English',style: TextStyle(fontSize: 20),),

                ),
                DropdownMenuItem(
                  value: Locale('ar'),
                  child: Text('Arabic',style: TextStyle(fontSize: 20),),
                ),
              ],
              onChanged: (locale) {
                context.setLocale(locale!);
              },
            ),
            SizedBox(height: 20),
            Text('mode',style: TextStyle(fontSize: 25),).tr(),
            DropdownButton<bool>(
              value: themeProvider.themeMode == ThemeMode.dark,
              items: [
                DropdownMenuItem(
                  value: false,
                  child: Text('light',style: TextStyle(fontSize: 20),).tr(),
                ),
                DropdownMenuItem(
                  value: true,
                  child: Text('dark',style: TextStyle(fontSize: 20),).tr(),
                ),
              ],
              onChanged: (isDarkMode) {
                themeProvider.toggleTheme(isDarkMode!);
              },
            ),
          ],
        ),
      ),

    );
  }
}
