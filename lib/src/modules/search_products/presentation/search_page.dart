import 'package:flutter/material.dart';
import 'package:kondus/src/modules/search_products/presentation/search_controller.dart';
import 'package:kondus/src/modules/search_products/presentation/search_state.dart';
import 'package:kondus/src/modules/search_products/widgets/product_card.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchPageController controller = SearchPageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KondusAppBar(
        title: 'Buscar Produtos ou Serviços',
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final state = controller.state;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KondusTextFormField(
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: context.lightGreyColor,
                  hintText: 'Digite para pesquisar...',
                  controller: controller.searchController,
                  onChanged: controller.onSearchChanged,
                ),
                if (controller.searchController.text.isNotEmpty)
                  const SizedBox(height: 24),
                Expanded(
                  child: _buildStateContent(state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStateContent(SearchState state) {
    if (state is SearchInitial || controller.searchController.text.isEmpty) {
      return const Center(
        child: Text(
          'Digite algo para começar a busca. 😎',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    } else if (state is SearchLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SearchSuccess) {
      return ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final product = state.products[index];
          return ProductCard(
            product: product,
            onTap: () {},
          );
        },
      );
    } else if (state is SearchFailure) {
      return Center(
        child: Text(
          state.errorMessage,
          style: const TextStyle(fontSize: 18),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
