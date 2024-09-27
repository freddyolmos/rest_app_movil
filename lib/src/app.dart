import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_app_movil/src/app_router.dart';

// import 'package:dashboard/generated/l10n.dart';
import 'package:rest_app_movil/src/providers/webapi_provider.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> loadAppSettings(BuildContext context) async {
    try {
      final jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/settings/appsettings.json');
      final appSettings = jsonDecode(jsonString);
      if (appSettings is Map<String, dynamic>) {
        final webApiBaseUrl = appSettings['webapiSettings']['baseUrl'];

        WebApiProvider.baseUrl = webApiBaseUrl;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadAppSettings(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return MaterialApp.router(
              routerConfig: AppRouter.routerConfig,
              // Providing a restorationScopeId allows the Navigator built by the
              // MaterialApp to restore the navigation stack when a user leaves and
              // returns to the app after it has been killed while running in the
              // background.
              restorationScopeId: 'app',
              theme: ThemeData(
                  useMaterial3: true,
                  colorSchemeSeed: const Color(0xFF008B91),
                  brightness: Brightness.light),
              // Provide the generated AppLocalizations to the MaterialApp. This
              // allows descendant Widgets to display the correct translations
              // depending on the user's locale.
              // locale: const Locale.fromSubtags(languageCode: 'en'),
              locale: const Locale.fromSubtags(
                  languageCode: 'es', countryCode: 'MX'));
        });
  }
}
