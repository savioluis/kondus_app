import 'package:flutter/material.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/header_section.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/core/widgets/photo_view_page.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  _RegisterProductPageState createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  // Lista de URLs das imagens
  final List<String> _imageUrls = [];

  // Controlador para gerenciar o estado
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
              controller: _nameController,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Descrição'),
            KondusTextFormField(
              hintText: 'Digite a descrição do produto',
              controller: _descriptionController,
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Imagens'),
            _buildImageListView(context),
            const SizedBox(height: 48),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 164,
                child: KondusButton(
                  label: 'CADASTRAR',
                  onPressed: () {
                    // Ação ao cadastrar
                    debugPrint('Nome: ${_nameController.text}');
                    debugPrint('Descrição: ${_descriptionController.text}');
                    debugPrint('Imagens: $_imageUrls');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Item adicionado com sucesso !',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                    NavigatorProvider.goBack();
                  },
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

  Widget _buildImageListView(BuildContext context) {
    return SizedBox(
      height: 148,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _imageUrls.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddImageButton(context);
          }
          return _buildImageTile(context, _imageUrls[index - 1]);
        },
      ),
    );
  }

  Widget _buildAddImageButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        borderRadius: BorderRadius.circular(18),
        color: context.lightGreyColor.withOpacity(0.3),
        child: InkWell(
          onTap: () {
            setState(() {
              _imageUrls.add('https://placehold.co/150.png');
            });
          },
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: context.lightGreyColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_library,
                  size: 64,
                  color: context.whiteColor,
                ),
                const SizedBox(height: 4),
                Text(
                  'Enviar',
                  textAlign: TextAlign.center,
                  style: context.headlineLarge!.copyWith(
                    color: context.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
          onLongPress: () {
            _showDeleteConfirmationDialog(context, imageUrl);
          },
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

  void _showDeleteConfirmationDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Excluir imagem"),
          content: const Text("Tem certeza que deseja excluir esta imagem?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _imageUrls.remove(imageUrl);
                });
                Navigator.of(context).pop();
              },
              child: Text(
                "Excluir",
                style: TextStyle(color: context.errorColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
