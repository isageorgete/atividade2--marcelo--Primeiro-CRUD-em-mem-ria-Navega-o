import '../domain_models/servico.dart';

abstract class ServicoRepository {
  List<Servico> getAll();
  void add(Servico s);
  void update(Servico s);
  void delete(String id);
}
/**/ 