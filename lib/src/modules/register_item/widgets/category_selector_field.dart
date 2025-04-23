import 'package:flutter/material.dart';
import 'package:kondus/core/services/dtos/items/category_dto.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';

class CategorySelectorField extends StatelessWidget {
  final List<CategoryDTO> selectedCategories;
  final List<CategoryDTO> allCategories;
  final void Function(List<CategoryDTO>) onSelectionChanged;

  const CategorySelectorField({
    super.key,
    required this.selectedCategories,
    required this.allCategories,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openCategoryModal(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          border: Border.all(color: context.lightGreyColor),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: selectedCategories.isEmpty
                  ? Text(
                      'Selecione as categorias',
                      style: context.bodyLarge!.copyWith(
                        color: context.lightGreyColor.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    )
                  : Wrap(
                      spacing: 4,
                      runSpacing: 8,
                      alignment: WrapAlignment.start,
                      children: [
                        ...selectedCategories.map(
                          (categorie) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: context.surfaceColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: context.blueColor.withOpacity(0.5),
                              ),
                            ),
                            child: Text(
                              categorie.name,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Icon(Icons.arrow_drop_down, color: context.primaryColor),
          ],
        ),
      ),
    );
  }

  Future<void> _openCategoryModal(BuildContext context) async {
    final selected = await showModalBottomSheet<List<CategoryDTO>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _CategorySelectionModal(
        allCategories: allCategories,
        initialSelection: selectedCategories,
      ),
    );

    if (selected != null) {
      onSelectionChanged(selected);
    }
  }
}

class _CategorySelectionModal extends StatefulWidget {
  final List<CategoryDTO> allCategories;
  final List<CategoryDTO> initialSelection;

  const _CategorySelectionModal({
    required this.allCategories,
    required this.initialSelection,
  });

  @override
  State<_CategorySelectionModal> createState() =>
      _CategorySelectionModalState();
}

class _CategorySelectionModalState extends State<_CategorySelectionModal> {
  late Set<CategoryDTO> _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelection.toSet();
  }

  void _toggle(CategoryDTO category) {
    setState(() {
      if (_selected.contains(category)) {
        _selected.remove(category);
      } else {
        _selected.add(category);
      }
    });
  }

  void _apply() {
    Navigator.of(context).pop(_selected.toList());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.lightGreyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: widget.allCategories.length + 1,
                    separatorBuilder: (_, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categorias',
                              style:
                                  context.headlineLarge!.copyWith(fontSize: 32),
                            ),
                            if (_selected.isNotEmpty)
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selected.clear();
                                  });
                                },
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.delete,
                                  color: context.errorColor,
                                  size: 24,
                                ),
                              ),
                          ],
                        );
                      }

                      final category = widget.allCategories[index - 1];
                      return CheckboxListTile(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text(category.name),
                        value: _selected.contains(category),
                        activeColor: context.blueColor,
                        tileColor: context.lightGreyColor.withOpacity(0.2),
                        onChanged: (_) => _toggle(category),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                KondusButton(
                  label: _selected.isEmpty
                      ? 'Aplicar filtros'
                      : 'Aplicar ${_selected.length} filtros',
                  onPressed: _apply,
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
