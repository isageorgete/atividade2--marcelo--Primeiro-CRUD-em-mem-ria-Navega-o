import 'package:flutter/material.dart';

import '../application/servico_controller.dart';
import '../data/servico_repository_fake.dart';
import '../domain_models/servico.dart';
import 'form_servico_page.dart';
class ListaServicoPage extends StatefulWidget {
  const ListaServicoPage({super.key});

  @override
  State<ListaServicoPage> createState() => _ListaServicoPageState();
}

class _ListaServicoPageState extends State<ListaServicoPage> {
  final controller = ServicoController(ServicoRepositoryFake());

  @override
  void initState() {
    super.initState();
    controller.carregar();
  }

  void atualizar() {
    setState(() => controller.carregar());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Laboratório Mobile")),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormServicoPage(controller: controller),
            ),
          );
          atualizar();
        },
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: controller.servicos.length,
        itemBuilder: (context, index) {
          final s = controller.servicos[index];

          return ListTile(
            title: Text(s.titulo),
            subtitle: Text(s.descricao),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            FormServicoPage(controller: controller, servico: s),
                      ),
                    );
                    atualizar();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => confirmarDelete(s.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void confirmarDelete(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar exclusão"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              controller.remover(id);
              atualizar();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Removido com sucesso")),
              );
            },
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
  }
}