class Restaurante {}

class RepositorioRestaurantes {
  static final RepositorioRestaurantes _singleton =
      RepositorioRestaurantes._internal();

  List<Restaurante>? listaRestaurantes;

  factory RepositorioRestaurantes() {
    return _singleton;
  }

  RepositorioRestaurantes._internal();
}
