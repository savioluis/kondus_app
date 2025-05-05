import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/chat/contact_list/widgets/contact_tile.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'contact_list_controller.dart';
import 'contact_list_state.dart';

class ContactListPage extends StatelessWidget {
  final ContactListController controller = ContactListController();

  ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KondusAppBar(),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final state = controller.state;

          if (state is ContactListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactListFailure) {
            return Center(child: Text('Erro: ${state.errorMessage}'));
          } else if (state is ContactListSuccess) {
            if (state.contacts.isEmpty) {
              return const Center(
                child: Text('Nenhum contato disponível'),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Últimas conversas',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.contacts.length,
                      itemBuilder: (context, index) {
                        final contact = state.contacts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: ContactTile(
                            name: contact.name,
                            apartment: contact.location,
                            onTap: () {
                              NavigatorProvider.navigateTo(
                                AppRoutes.contactChat,
                                arguments: RouteArguments<List<String>>(
                                  [contact.id, contact.name],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('Bem-vindo!'));
        },
      ),
    );
  }
}
