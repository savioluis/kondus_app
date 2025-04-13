import 'package:flutter/material.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/header_section.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/core/widgets/photo_view_page.dart';
import 'package:kondus/src/modules/home/widgets/product_card.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_controller.dart';

class RegisterItemPage extends StatefulWidget {
  const RegisterItemPage({required this.itemType, super.key});

  final ItemType itemType;

  @override
  _RegisterItemPageState createState() => _RegisterItemPageState();
}

class _RegisterItemPageState extends State<RegisterItemPage> {

  late final RegisterItemController controller;

  @override
  void initState() {
    super.initState();
    controller = RegisterItemController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KondusAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderSection(
              title: 'Insira as informações do seu produto',
              titleSize: 30,
              subtitle: [
                TextSpan(text: 'Cadastre o seu '),
                TextSpan(
                  text: 'produto',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 48),
            _buildSectionTitle('Nome'),
            KondusTextFormField(
              hintText: 'Digite o nome do produto',
              controller: controller.nameEC,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Descrição'),
            KondusTextFormField(
              hintText: 'Digite a descrição do produto',
              controller: controller.descriptionEC,
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Imagens'),
            const SizedBox(height: 48),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 164,
                child: KondusButton(
                  label: 'CADASTRAR',
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _buildImageTile(BuildContext context, String imageUrl) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoViewPage(imageUrl: imageUrl),
              ),
            );
          },
          onLongPress: () {},
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
