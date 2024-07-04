import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/main.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/settings_provider.dart';

import '../common/localization.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({
    super.key,
    required this.onLogout,
  });

  final Function() onLogout;

  @override
  Widget build(BuildContext context) {
    final settingProvider = context.watch<SettingsProvider>();
    final authProvider = context.watch<AuthProvider>();

    final accountInfo = authProvider.loginResults;
    final isDarkTheme = settingProvider.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          accountInfo?.name ?? appLocale.account,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                accountInfo?.name.substring(0, 1) ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 64),
            ListTile(
              leading: Icon(isDarkTheme ? Icons.dark_mode : Icons.light_mode),
              title: Text(appLocale.theme),
              trailing: Switch(
                value: isDarkTheme,
                onChanged: (value) async {
                  Provider.of<SettingsProvider>(
                    context,
                    listen: false,
                  ).enableDarkTheme(value);
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.flag_sharp),
              title:  Text(appLocale.language),
              trailing: DropdownButton(
                icon: Text(Localization.getFlag(settingProvider.languageCode)),
                items: AppLocalizations.supportedLocales.map((Locale locale) {
                  final flag = Localization.getFlag(locale.languageCode);
                  final accFlag = getLanguageAccessibility(context, locale.languageCode);
                  return DropdownMenuItem(
                    value: locale,
                    child: Center(
                      child: Text(
                        flag,
                        style: Theme.of(context).textTheme.headlineMedium,
                        semanticsLabel: accFlag,
                      ),
                    ),
                    onTap: () {
                      final provider = Provider.of<SettingsProvider>(
                        context,
                        listen: false,
                      );
                      provider.setLanguage(locale.languageCode);
                    },
                  );
                }).toList(),
                onChanged: (_){},
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                    style: BorderStyle.solid,
                  ),
                ),
                onPressed: () async {
                  final authRead = context.read<AuthProvider>();
                  final result = await authRead.logout();
                  if (result) onLogout();
                },
                child: authProvider.isLoadingLogout
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : Text(
                        appLocale.logout,
                        style: const TextStyle(color: Colors.red),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getLanguageAccessibility(BuildContext context, String languageCode) {
    switch (languageCode) {
      case "en":
        return appLocale.localeItem2;
      case "id":
      default:
        return appLocale.localeItem1;
    }
  }
}
