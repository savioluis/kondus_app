import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/http/i_http_provider.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/repositories/i_token_repository.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/home/presentation/home_controller.dart';
import 'package:kondus/src/modules/home/presentation/home_state.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_item_slider.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_title.dart';
import 'package:kondus/src/modules/home/widgets/app_bar/home_app_bar.dart';
import 'package:kondus/src/modules/home/widgets/product_card.dart';
import 'package:kondus/src/modules/home/widgets/search_bar_button.dart';
import 'package:kondus/core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  final controller = TextEditingController();
}

class _HomePageState extends State<HomePage> {
  final contacts = [
    {'uid': '1', 'name': 'Alice', 'apartment': 'Apartamento 1 - Bloco A'},
    {'uid': '2', 'name': 'Bob', 'apartment': 'Apartamento 2 - Bloco D'},
    {'uid': '3', 'name': 'Charlie', 'apartment': 'Apartamento 105 - Bloco B'},
    {'uid': '4', 'name': 'David', 'apartment': 'Apartamento 309 - Bloco J'},
    {'uid': '5', 'name': 'Elias', 'apartment': 'Apartamento  - Bloco H'},
    {'uid': '6', 'name': 'Filipe', 'apartment': 'Casa 3'},
    {'uid': '7', 'name': 'Greg', 'apartment': 'Casa 06'},
    {'uid': '8', 'name': 'Heitor', 'apartment': 'Casa 06'},
    {'uid': '9', 'name': 'Isabel', 'apartment': 'Casa 27'},
    {
      'uid': '10',
      'name': 'Jay',
      'apartment': 'Apartamento 48 - Torre 3 - Bloco 1'
    },
  ];

  String selectedCategory = 'Todos';

  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController()..loadInitialData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final state = controller.state;
        if (state is HomeLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeFailureState) {
          return ErrorStateWidget(
            error: state.error,
            onRetryPressed: () => controller.loadInitialData(),
            onBackButtonPressed: () => controller.logout(),
          );
        } else if (state is HomeSuccessState) {
          final currentState = state;
          return Scaffold(
            appBar: HomeAppBar(username: currentState.user.name),
            body: RefreshIndicator(
              onRefresh: () async => await controller.loadInitialData(),
              backgroundColor: context.blueColor,
              color: context.whiteColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ContactTitle(
                        onTap: () => NavigatorProvider.navigateTo(
                          AppRoutes.contactList,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ContactItemSlider(
                      contacts: contacts,
                      itemCount: contacts.length,
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SearchBarButton(
                        onTap: () => NavigatorProvider.navigateTo(
                          AppRoutes.searchProducts,
                        ),
                      ),
                    ),
                    const SizedBox(height: 96),
                    SizedBox(
                      height: 48,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategoryChip('Todos'),
                          _buildCategoryChip('Comprar'),
                          _buildCategoryChip('Alugar'),
                          _buildCategoryChip('Contratar'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    state.isLoadingMoreItems
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: currentState.items.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: currentState.items.length,
                                    itemBuilder: (context, index) {
                                      final product = currentState.items[index];
                                      return ProductCard(
                                        imageUrl: product.imagesPaths.isNotEmpty
                                            ? product.imagesPaths.first
                                            : null,
                                        name: product.name,
                                        category: product.categories[0].name,
                                        actionType: product.type
                                            .toActionType(product.quantity),
                                        onTap: () {
                                          NavigatorProvider.navigateTo(
                                            AppRoutes.productDetails,
                                            arguments:
                                                RouteArguments<int>(product.id),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(top: 144),
                                    child: Text('Nenhum produto encontrado'),
                                  ),
                          ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCategoryChip(String category) {
    bool isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedCategory = category;
        });
        await controller.loadItemsWithCategoryFilter(category);
      },
      child: Container(
        margin: category == 'Todos'
            ? const EdgeInsets.symmetric(horizontal: 12)
            : const EdgeInsets.only(right: 12),
        child: Chip(
          label: Text(category.toUpperCase()),
          backgroundColor:
              isSelected ? context.blueColor : context.surfaceColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: context.lightGreyColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          labelStyle: TextStyle(
            color: isSelected ? context.whiteColor : context.primaryColor,
          ),
        ),
      ),
    );
  }
}

_testTela(VoidCallback setState) {
  File? imageFile;
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          if (imageFile != null) Image.file(imageFile),
          ElevatedButton(
            onPressed: () async {
              final picker = ImagePicker();
              final result = await picker.pickMultiImage();

              if (result.isNotEmpty) {
                final files = result.map((xfile) => File(xfile.path)).toList();
                imageFile = files[0];
                setState();
              }
            },
            child: Text('Upload'),
          ),
          ElevatedButton(
            onPressed: () async {
              final _tokenRepository = GetIt.instance<ITokenRepository>();
              final token = await _tokenRepository.getAccessToken();
              final imageFilePath = imageFile!.path;
              final itemId = 50;
              final body = FormData.fromMap({
                "image": await MultipartFile.fromFile(imageFilePath),
                "itemId": itemId.toString(),
              });

              final dio = Dio(BaseOptions(baseUrl: 'http://0.0.0.0:8080'));

              dio.interceptors.add(
                LogInterceptor(
                  requestBody: true,
                  responseBody: true,
                  error: true,
                ),
              );

              final response = await dio.post(
                '/items/images',
                options: Options(
                  headers: {
                    'Content-Type': 'multipart/form-data',
                    'Authorization': 'Bearer $token',
                  },
                ),
                data: body,
              );

              log(response.toString());
            },
            child: Text('Enviar'),
          ),
        ],
      ),
    ),
  );
}

Image imageteste() {
  return Image.network(
    "http://0.0.0.0:8080/items/images/RvUC-SZVqM8sAgi-image_picker_935FB777-60A0-4C8C-8C9F-A9DEDBB78207-68682-0000032A06403D1A.jpg",
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJteS1hdWRpZW5jZSIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QiLCJpZCI6MSwiZXhwIjoxNzQ1MjcwMzYzfQ.Xp5eEGm6xAxlM0FJqG-oeZRNl761J_7H3I_CTSaTtQg',
    },
  );
}
