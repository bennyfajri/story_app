import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:story_app/my_app.dart';

import '../provider/settings_provider.dart';

class BuyPremiumScreen extends StatelessWidget {
  const BuyPremiumScreen({
    super.key,
    required this.onSuccess,
  });

  final Function() onSuccess;

  @override
  Widget build(BuildContext context) {
    final settingProvider = context.watch<SettingsProvider>();
    final isPremiumUser = settingProvider.isPremiumUser;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Transform.rotate(
                angle: 3.14,
                child: Lottie.asset("assets/abstract_animation.json"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocale.upgrade_premium,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(appLocale.upgrade_premium_desc),
                  const SizedBox(height: 24),
                  if(!isPremiumUser) Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue,
                        ),
                        child: const Text(
                          "100%",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Localizations.override(
                        context: context,
                        locale: const Locale("id"),
                        child: Builder(
                          builder: (context) {
                            return Text(
                              appLocale.premiumPackagePrice(45000),
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Provider.of<SettingsProvider>(
                          context,
                          listen: false,
                        ).enablePremiumUser(!isPremiumUser);
                        onSuccess();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(isPremiumUser ? appLocale.premium_user : appLocale.upgrade_premium),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
