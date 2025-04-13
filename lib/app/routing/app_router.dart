import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/chat/contact_chat/presentation/contact_chat_page.dart';
import 'package:kondus/src/modules/chat/contact_list/presentation/contact_list_page.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/home/presentation/home_page.dart';
import 'package:kondus/src/modules/lend_your_products/presentation/lend_your_products_page.dart';
import 'package:kondus/src/modules/login/presentation/login_page.dart';
import 'package:kondus/src/modules/my_announcements/presentation/my_announcements_page.dart';
import 'package:kondus/src/modules/notifications/presentation/notifications_page.dart';
import 'package:kondus/src/modules/privacy_policy/presentation/privacy_policy_page.dart';
import 'package:kondus/src/modules/product_details/presentation/product_details_page.dart';
import 'package:kondus/src/modules/register/presentation/register_page.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_page.dart';
import 'package:kondus/src/modules/search_products/presentation/filter_page.dart';
import 'package:kondus/src/modules/search_products/presentation/search_page.dart';
import 'package:kondus/src/modules/settings/presentation/settings_page.dart';
import 'package:kondus/src/modules/terms_and_conditions/presentation/terms_and_conditions_page.dart';
import 'package:kondus/src/modules/welcome/presentation/welcome_page.dart';
import 'package:kondus/src/modules/profile/presentation/profile_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
          settings: settings,
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
          settings: settings,
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
          settings: settings,
        );
      case AppRoutes.searchProducts:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
          settings: settings,
        );
      case AppRoutes.productDetails:
        final id = settings.arguments as RouteArguments<int>;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(productId: id.data),
          settings: settings,
        );
      case AppRoutes.lendYourProducts:
        return MaterialPageRoute(
          builder: (_) => const LendYourProductsPage(),
          settings: settings,
        );
      case AppRoutes.registerItem:
        return MaterialPageRoute(
          builder: (_) => const RegisterItemPage(),
          settings: settings,
        );
      case AppRoutes.appSettings:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
          settings: settings,
        );
      case AppRoutes.contactList:
        return MaterialPageRoute(
          builder: (_) => ContactListPage()..controller.fetchContacts(),
          settings: settings,
        );
      case AppRoutes.contactChat:
        return MaterialPageRoute(
          builder: (_) => const ContactChatPage(
            apartment: 'Casa 7',
            name: 'Teresa',
            uid: '1',
          ),
          settings: settings,
        );
      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsPage(),
          settings: settings,
        );
      case AppRoutes.privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyPage(),
          settings: settings,
        );
      case AppRoutes.termsAndConditions:
        return MaterialPageRoute(
          builder: (_) => const TermsAndConditionsPage(),
          settings: settings,
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
          settings: settings,
        );
      case AppRoutes.myAnnouncements:
        return MaterialPageRoute(
          builder: (_) => const MyItemsPage(),
          settings: settings,
        );
      case AppRoutes.filter:
        final currentCategories =
            settings.arguments as RouteArguments<List<CategoryModel>?>;
        return MaterialPageRoute(
          builder: (_) => FilterPage(
            currentCategories: currentCategories.data,
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: const KondusAppBar(),
            body: Center(
              child: Text('A seguinte rota não existe: ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
