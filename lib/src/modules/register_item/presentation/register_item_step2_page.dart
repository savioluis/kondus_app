import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_controller.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_state.dart';
import 'package:kondus/src/modules/register_item/widgets/register_item_appbar.dart';

class RegisterItemStep2Page extends StatefulWidget {
  const RegisterItemStep2Page({super.key});

  @override
  State<RegisterItemStep2Page> createState() => _RegisterItemStep2PageState();
}

class _RegisterItemStep2PageState extends State<RegisterItemStep2Page> {
  late final RegisterItemController controller;

  @override
  void initState() {
    super.initState();
    controller = RegisterItemController()..loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final state = controller.state;
        if (state is RegisterItemLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is RegisterItemFailureState) {
          return ErrorStateWidget(
            error: state.error,
            onRetryPressed: () {},
          );
        } else if (state is RegisterItemSuccessState) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Nome'),
                    KondusTextFormField(
                      hintText: 'Digite o nome do produto',
                      controller: controller.nameEC,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Preço'),
                    KondusTextFormField(
                      hintText: 'Digite o valor do produto',
                      controller: controller.priceEC,
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Descrição'),
                    KondusTextFormField(
                      hintText: 'Digite a descrição do produto',
                      controller: controller.descriptionEC,
                      maxLines: 4,
                    ),
                    // _buildSectionTitle('Imagens'),
                    const SizedBox(height: 24),
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
}

Widget _buildSectionTitle(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
    ],
  );
}

// _buildSectionTitle('Tipo'),
//                     CustomDropdownField(
//                       hint: 'Selecione o tipo do item',
//                       items: const ['Venda', 'Aluguel', 'Serviço'],
//                       value: controller.selectedType,
//                       enabled: controller.selectedType == null,
//                       onChanged: (value) {
//                         // controller.selectedType = value;
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     _buildSectionTitle('Categoria'),
//                     CustomDropdownField(
//                       hint: 'Selecione a categoria',
//                       items: state.categories,
//                       value: controller.selectedType,
//                       enabled: controller.selectedType == null,
//                       onChanged: (value) {
//                         // controller.selectedType = value;
//                       },
//                     ),
//                     const SizedBox(height: 24),