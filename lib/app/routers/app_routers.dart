import 'package:flutter/material.dart';
import 'package:kondus/src/modules/home/presentation/home_page.dart';
import 'package:kondus/src/modules/login/presentation/login_page.dart';
import 'package:kondus/src/modules/privacy_policy/presentation/privacy_policy_page.dart';
import 'package:kondus/src/modules/product_details/presentation/product_details_page.dart';
import 'package:kondus/src/modules/search/presentation/search_page.dart';
import 'package:kondus/src/modules/settings/presentation/settings_page.dart';
import 'package:kondus/src/modules/terms_and_conditions/presentation/terms_and_conditions_page.dart';
import 'package:kondus/src/modules/welcome/presentation/welcome_page.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static const String searchProducts = '/searchProducts';
  static const String productDetails = '/productDetails';

  static const String appSettings = '/settings';
  static const String privacyPolicy = '/privacyPolicy';
  static const String termsAndConditions = '/termsAndConditions';

  // Método para gerar as rotas
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(
            builder: (_) => const WelcomePage(), settings: settings);
      case login:
        return MaterialPageRoute(
            builder: (_) => const LoginPage(), settings: settings);
      case home:
        return MaterialPageRoute(
            builder: (_) => const HomePage(), settings: settings);
      case searchProducts:
        return MaterialPageRoute(
            builder: (_) => const SearchPage(), settings: settings);
      case productDetails:
        return MaterialPageRoute(
            builder: (_) => const ProductDetailsPage(), settings: settings);
      case appSettings:
        return MaterialPageRoute(
            builder: (_) => const SettingsPage(), settings: settings);
      case privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyPage(),
          settings: settings,
        );
      case termsAndConditions:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionsPage(), settings: settings);
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('A seguinte rota não existe ${settings.name}'),
            ),
          ),
        );
    }
  }
}
