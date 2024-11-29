/*
categoria: 'Extra Large Pizza',
            nome: 'Extra Large Meat Lovers',
            descricao: 'Whole pie.',
            preco: '15.99 USD'
*/

class ItemCardapio {
  final String? categoria;
  final String? nome;
  final String? descricao;
  final String? preco;

  ItemCardapio(this.categoria, this.nome, this.descricao, this.preco);

  ItemCardapio.fromJson(Map<String, dynamic> json)
      : categoria = json['categoria'] as String?,
        nome = json['nome'] as String?,
        descricao = json['descricao'] as String?,
        preco = json['preco'] as String?;
}

class RepositorioCardapio {
  static final RepositorioCardapio _singleton = RepositorioCardapio._internal();

  static List<ItemCardapio> listaItens = [];
  static String? campoBusca;

  List<ItemCardapio> getCardapio() {
    List<ItemCardapio> resultado = [];

    if (campoBusca != null) {
      resultado.addAll(listaItens
          .where((restaurante) => restaurante.nome!.contains(campoBusca!)));
    } else {
      resultado.addAll(listaItens);
    }

    return resultado;
  }

  factory RepositorioCardapio() {
    return _singleton;
  }

  RepositorioCardapio._internal();
}
