import '../domain_models/servico.dart';
import '../repositories/servico_repository.dart';
class ServicoController {
  final ServicoRepository repository;

  ServicoController(this.repository);

  List<Servico> servicos = [];

  void carregar() {
    servicos = repository.getAll();
  }

  void criar(Servico s) {
    repository.add(s);
    carregar();
  }

  void editar(Servico s) {
    repository.update(s);
    carregar();
  }

  void remover(String id) {
    repository.delete(id);
    carregar();
  }
}