import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/my_app.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/settings_provider.dart';

import '../common/localization.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({
    super.key,
    required this.onLogout,
    required this.onPremium,
  });

  final Function() onLogout;
  final Function() onPremium;

  @override
  Widget build(BuildContext context) {
    final settingProvider = context.watch<SettingsProvider>();
    final authProvider = context.watch<AuthProvider>();

    final accountState = authProvider.accountState;
    final logoutState = authProvider.logoutState;
    final isDarkTheme = settingProvider.isDarkTheme;
    final isPremiumUser = settingProvider.isPremiumUser;

    return accountState.map(
      empty: (value) {
        return const SliverToBoxAdapter(
          child: Center(
            child: Text('No images Found'),
          ),
        );
      },
      loading: (value) {
        return const Center(child: CircularProgressIndicator());
      },
      loaded: (value) {
        final accountInfo = value.data;
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: buildLinearGradient(context),
                            ),
                            child: Text(
                              accountInfo?.name.substring(0, 1) ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 64),
                        ListTile(
                          leading: Icon(isDarkTheme
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined),
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
                          leading: const Icon(Icons.flag_outlined),
                          title: Text(appLocale.language),
                          trailing: DropdownButton(
                            icon: Text(Localization.getFlag(
                                settingProvider.languageCode)),
                            items: AppLocalizations.supportedLocales
                                .map((Locale locale) {
                              final flag =
                                  Localization.getFlag(locale.languageCode);
                              final accFlag = getLanguageAccessibility(
                                  context, locale.languageCode);
                              return DropdownMenuItem(
                                value: locale,
                                child: Center(
                                  child: Text(
                                    flag,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    semanticsLabel: accFlag,
                                  ),
                                ),
                                onTap: () {
                                  final provider =
                                      Provider.of<SettingsProvider>(
                                    context,
                                    listen: false,
                                  );
                                  provider.setLanguage(locale.languageCode);
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                        InkWell(
                          onTap: onPremium,
                          borderRadius: BorderRadius.circular(50),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: buildLinearGradient(context),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ListTile(
                              leading: Icon(
                                isPremiumUser
                                    ? Icons.verified_outlined
                                    : Icons.person,
                                color: Colors.white,
                              ),
                              title: Text(
                                isPremiumUser
                                    ? appLocale.premium_user
                                    : appLocale.upgrade_premium,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: isPremiumUser
                                  ? null
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.upgrade_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    child: logoutState.map(
                      empty: (value) {
                        return Text(
                          appLocale.logout,
                          style: const TextStyle(color: Colors.red),
                        );
                      },
                      loading: (value) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      },
                      loaded: (value) {
                        return Text(
                          appLocale.logout,
                          style: const TextStyle(color: Colors.red),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  LinearGradient buildLinearGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.secondary,
      ],
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
