import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/search_products/presentation/search_controller.dart';

class SearchPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchPageAppBar({
    required this.controller,
    required this.title,
    this.onBackButtonPressed,
    super.key,
  });

  final SearchPageController controller;
  final String title;
  final void Function()? onBackButtonPressed;

  @override
  Size get preferredSize => const Size.fromHeight(238);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.surfaceColor,
      child: SafeArea(
        top: true,
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            final selectedCategories = controller.selectedCategories;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: IconButton(
                    onPressed: onBackButtonPressed ?? NavigatorProvider.goBack,
                    icon: Icon(
                      Icons.arrow_back,
                      color: context.onSurfaceColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            color: context.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: KondusTextFormField(
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: context.lightGreyColor,
                              hintText: 'Digite para pesquisar...',
                              controller: controller.searchController,
                              onChanged: controller.onSearchChanged,
                              sufixIcon: controller
                                      .searchController.value.text.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.searchController.clear();
                                        controller.onSearchChanged(controller
                                            .searchController.value.text);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: context.lightGreyColor
                                            .withOpacity(0.5),
                                        size: 20,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: Stack(
                              alignment: const Alignment(1.5, 1.5),
                              children: [
                                InkWell(
                                  onTap: () async {
                                    final result =
                                        await NavigatorProvider.navigateTo(
                                      AppRoutes.filter,
                                      arguments:
                                          RouteArguments<List<CategoryModel>>(
                                        selectedCategories,
                                      ),
                                    ) as RouteArguments<List<CategoryModel>?>?;

                                    if (result?.data != null) {
                                      controller
                                          .onFiltersChanged(result!.data!);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Ink(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: context.blueColor.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.filter_list_sharp,
                                        color: context.whiteColor,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                                if (selectedCategories.isNotEmpty)
                                  Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      color: context.surfaceColor,
                                      border: Border.all(
                                          color: context.lightGreyColor),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        selectedCategories.length < 10
                                            ? '${selectedCategories.length}'
                                            : '9+',
                                        style: TextStyle(
                                          color: context.secondaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
