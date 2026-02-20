import '../domain_models/servico.dart';
import '../repositories/servico_repository.dart';

class ServicoRepositoryFake implements ServicoRepository {
  final List<Servico> _servicos = [
    Servico(
      id: "1",
      titulo: "Troca de óleo",
      descricao: "Manutenção preventiva",
    ),
    Servico(
      id: "2",
      titulo: "Limpeza",
      descricao: "Limpeza geral",
    ),
  ];

  @override
  List<Servico> getAll() => _servicos;

  @override
  void add(Servico s) {
    _servicos.add(s);
  }

  @override
  void update(Servico s) {
    final index = _servicos.indexWhere((e) => e.id == s.id);
    if (index != -1) _servicos[index] = s;
  }

  @override
  void delete(String id) {
    _servicos.removeWhere((e) => e.id == id);
  }
}