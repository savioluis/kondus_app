import 'package:flutter/material.dart';
import 'package:kondus/src/modules/chat/contact_chat/presentation/contact_chat_page.dart';
import 'package:kondus/src/modules/chat/contact_list/presentation/contact_list_page.dart';
import 'package:kondus/src/modules/history/presentation/history_page.dart';
import 'package:kondus/src/modules/home/presentation/home_page.dart';
import 'package:kondus/src/modules/lend_your_products/presentation/lend_your_products_page.dart';
import 'package:kondus/src/modules/login/presentation/login_page.dart';
import 'package:kondus/src/modules/notifications/presentation/notifications_page.dart';
import 'package:kondus/src/modules/privacy_policy/presentation/privacy_policy_page.dart';
import 'package:kondus/src/modules/product_details/presentation/product_details_page.dart';
import 'package:kondus/src/modules/register/presentation/register_page.dart';
import 'package:kondus/src/modules/register_product/presentation/register_product_page.dart';
import 'package:kondus/src/modules/search_products/presentation/search_page.dart';
import 'package:kondus/src/modules/settings/presentation/settings_page.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/terms_and_conditions/presentation/terms_and_conditions_page.dart';
import 'package:kondus/src/modules/welcome/presentation/welcome_page.dart';

import '../../src/modules/profile/presentation/profile_page.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = "/profile";
  static const String searchProducts = '/searchProducts';
  static const String productDetails = '/productDetails';
  static const String lendYourProducts = '/lendYourProducts';
  static const String registerProduct = '/registerProduct';

  static const String contactList = '/contactList';
  static const String contactChat = '/contactChat';

  static const String appSettings = '/settings';
  static const String notifications = '/notifications';
  static const String privacyPolicy = '/privacyPolicy';
  static const String termsAndConditions = '/termsAndConditions';

  static const String history = "/history";

  // Método para gerar as rotas
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(
            builder: (_) => const WelcomePage(), settings: settings);
      case login:
        return MaterialPageRoute(
            builder: (_) => const LoginPage(), settings: settings);
      case register:
        return MaterialPageRoute(
            builder: (_) => const RegisterPage(), settings: settings);
      case home:
        return MaterialPageRoute(
            builder: (_) => HomePage(), settings: settings);
      case searchProducts:
        return MaterialPageRoute(
            builder: (_) => const SearchPage(), settings: settings);
      case productDetails:
        return MaterialPageRoute(
            builder: (_) => const ProductDetailsPage(), settings: settings);
      case lendYourProducts:
        return MaterialPageRoute(
          builder: (_) => const LendYourProductsPage(),
          settings: settings,
        );
      case registerProduct:
        return MaterialPageRoute(
          builder: (_) => const RegisterProductPage(),
          settings: settings,
        );
      case appSettings:
        return MaterialPageRoute(
            builder: (_) => const SettingsPage(), settings: settings);
      case contactList:
        return MaterialPageRoute(
            builder: (_) => ContactListPage()..controller.fetchContacts(),
            settings: settings);
      case contactChat:
        return MaterialPageRoute(
            builder: (_) => const ContactChatPage(apartment: 'Casa 7', name: 'Teresa', uid: '1',), settings: settings);

      case notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsPage(),
          settings: settings,
        );
      case privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyPage(),
          settings: settings,
        );
      case termsAndConditions:
        return MaterialPageRoute(
          builder: (_) => const TermsAndConditionsPage(),
          settings: settings,
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
          settings: settings,
        );
      case history:
        return MaterialPageRoute(
          builder: (_) => const HistoryPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            appBar: const KondusAppBar(),
            body: Center(
              child: Text('A seguinte rota não existe ${settings.name}'),
            ),
          ),
        );
    }
  }
}
