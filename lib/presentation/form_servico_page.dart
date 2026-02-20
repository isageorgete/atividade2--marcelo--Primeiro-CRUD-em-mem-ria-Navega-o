import 'package:flutter/material.dart';

import '../application/servico_controller.dart';
import '../domain_models/servico.dart';

class FormServicoPage extends StatefulWidget {
  final ServicoController controller;
  final Servico? servico;

  const FormServicoPage({
    super.key,
    required this.controller,
    this.servico,
  });

  @override
  State<FormServicoPage> createState() => _FormServicoPageState();
}

class _FormServicoPageState extends State<FormServicoPage> {
  final formKey = GlobalKey<FormState>();
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.servico != null) {
      tituloController.text = widget.servico!.titulo;
      descricaoController.text = widget.servico!.descricao;
    }
  }

  void salvar() {
    if (!formKey.currentState!.validate()) return;

    final servico = Servico(
      id: widget.servico?.id ?? DateTime.now().toString(),
      titulo: tituloController.text,
      descricao: descricaoController.text,
    );

    if (widget.servico == null) {
      widget.controller.criar(servico);
    } else {
      widget.controller.editar(servico);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.servico == null ? "Novo Serviço" : "Editar Serviço"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tituloController,
                decoration: const InputDecoration(labelText: "Título"),
                validator: (v) => v!.isEmpty ? "Obrigatório" : null,
              ),
              TextFormField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: "Descrição"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: salvar, child: const Text("Salvar")),
            ],
          ),
        ),
      ),
    );
  }
}