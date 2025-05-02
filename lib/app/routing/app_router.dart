import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/chat/contact_chat/presentation/contact_chat_page.dart';
import 'package:kondus/src/modules/chat/contact_list/presentation/contact_list_page.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/home/presentation/home_page.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_controller.dart';
import 'package:kondus/src/modules/share_your_items/presentation/share_your_items_page.dart';
import 'package:kondus/src/modules/login/presentation/login_page.dart';
import 'package:kondus/src/modules/my_announcements/presentation/my_announcements_page.dart';
import 'package:kondus/src/modules/notifications/presentation/notifications_page.dart';
import 'package:kondus/src/modules/privacy_policy/presentation/privacy_policy_page.dart';
import 'package:kondus/src/modules/product_details/presentation/item_details_page.dart';
import 'package:kondus/src/modules/register/presentation/register_page.dart';
import 'package:kondus/src/modules/register_item/presentation/step_1/register_item_step_1_page.dart';
import 'package:kondus/src/modules/register_item/presentation/step_2/register_item_step_2_page.dart';
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
      case AppRoutes.itemDetails:
        final args = settings.arguments as RouteArguments<List<dynamic>>;
        final id = args.data[0];
        final isOwnerAcessing = args.data[1];
        return MaterialPageRoute(
          builder: (_) => ItemDetailsPage(
            productId: id,
            isOwnerAcessing: isOwnerAcessing,
          ),
          settings: settings,
        );
      case AppRoutes.shareYourItems:
        final args = settings.arguments as RouteArguments<VoidCallback?>;
        final VoidCallback? onSkipPressed = args.data;
        return MaterialPageRoute(
          builder: (_) => ShareYourItemsPage(
            onSkipPressed: onSkipPressed,
          ),
          settings: settings,
        );
      case AppRoutes.registerItemStep1:
        final args = settings.arguments as RouteArguments<List<dynamic>>;
        final itemType = args.data[0];
        final itemName = args.data[1];
        final itemDescription = args.data[2];
        final itemCategoriesIds = args.data[3];
        final itemActionType = args.data[4];
        return MaterialPageRoute(
          builder: (_) => RegisterItemPage(
            itemType: itemType,
            itemName: itemName,
            description: itemDescription,
            categoriesIds: itemCategoriesIds,
            actionType: itemActionType,
          ),
          settings: settings,
        );
      case AppRoutes.registerItemStep2:
        final args = settings.arguments as RouteArguments<List<dynamic>>;
        final ItemType? itemType = args.data[0];
        final String name = args.data[1];
        final String description = args.data[2];
        final List<String>? imagesPaths = args.data[3];
        final String? itemActionType = args.data[4];
        final List<int>? itemCategoriesIds = args.data[5];
        return MaterialPageRoute(
          builder: (_) => RegisterItemStep2Page(
            itemType: itemType,
            name: name,
            description: description,
            imagesPaths: imagesPaths,
            actionType: itemActionType,
            categoriesIds: itemCategoriesIds,
          ),
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
        final args = settings.arguments as RouteArguments<List<String>>;
        final String targetId = args.data[0];
        final String name = args.data[1];
        return MaterialPageRoute(
          builder: (_) => ContactChatPage(
            targetId: targetId,
            name: name,
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
