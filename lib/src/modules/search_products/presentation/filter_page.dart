import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({required this.currentCategories, super.key});

  final List<CategoryModel>? currentCategories;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final _categoryService = GetIt.instance<ItemsService>();

  final List<CategoryModel> _categories = [];
  final Set<int> _selectedIndexes = {};
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final dtos = await _categoryService.getAllCategories();
      final loadedCategories =
          dtos.map((dto) => CategoryModel.fromDTO(dto)).toList();

      final previousSelection = widget.currentCategories ?? [];
      final selectedIndexes = <int>{};
      for (int i = 0; i < loadedCategories.length; i++) {
        final category = loadedCategories[i];
        if (previousSelection.any((c) => c.id == category.id)) {
          selectedIndexes.add(i);
        }
      }

      setState(() {
        _categories.addAll(loadedCategories);
        _selectedIndexes.addAll(selectedIndexes);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void toggleSelection(int index) {
    setState(() {
      if (_selectedIndexes.contains(index)) {
        _selectedIndexes.remove(index);
      } else {
        _selectedIndexes.add(index);
      }
    });
  }

  void applyFilters() {
    final selectedCategories =
        _selectedIndexes.map((i) => _categories[i]).toList();
    NavigatorProvider.goBackWithResult(
      RouteArguments<List<CategoryModel>?>(selectedCategories),
    );
  }

  @override
  Widget build(BuildContext context) {
    int amountSelected = _selectedIndexes.length;

    return Scaffold(
      appBar: KondusAppBar(
        title: 'Filtros',
        actions: [
          if (amountSelected > 0)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndexes.clear();
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: context.errorColor,
                  size: 24,
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : !_hasError
              ? RefreshIndicator(
                  onRefresh: () async {
                    _loadCategories();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: ListView.separated(
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return CheckboxListTile(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: Text(category.name),
                          value: _selectedIndexes.contains(index),
                          activeColor: context.blueColor,
                          tileColor: context.lightGreyColor.withOpacity(0.2),
                          onChanged: (_) => toggleSelection(index),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'Erro ao carregar os filtros.',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: KondusButton(
            label: amountSelected > 0
                ? 'Aplicar $amountSelected filtros'
                : 'Aplicar filtros',
            onPressed: applyFilters,
          ),
        ),
      ),
    );
  }
}
