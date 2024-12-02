/*
{
        "id": 26,
        "posicao": 123,
        "nome": " Five Point Public House Oyster Bar",
        "pontuacao": null,
        "avaliacoes": null,
        "categoria": "Seafood, Sushi, Steak",
        "endereco": "1210 20th St S, Birmingham, AL, 35205",
        "codigo_zip": "35205",
        "lat": 33.49906,
        "lng": -86.79597
    },
*/

import 'package:front_end/DAO/restaurantes.dart';
import 'package:front_end/Utils/result.dart';

class Restaurante {
  final int id;
  final int posicao;
  final String nome;
  final double? pontuacao;
  final int? avaliacoes;
  final String categoria;
  final String? endereco;
  final String? codigoZip;
  final double lat;
  final double lng;

  Restaurante(this.id, this.posicao, this.nome, this.pontuacao, this.avaliacoes,
      this.categoria, this.endereco, this.codigoZip, this.lat, this.lng);

  Restaurante.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        posicao = json['posicao'] as int,
        nome = json['nome'] as String,
        pontuacao = json['pontuacao'] as double?,
        avaliacoes = json['avaliacoes'] as int?,
        categoria = json['categoria'] as String,
        endereco = json['endereco'] as String?,
        codigoZip = json['codizo_zip'] as String?,
        lat = json['lat'] as double,
        lng = json['lng'] as double;
}

class RepositorioRestaurantes {
  static final RepositorioRestaurantes _singleton =
      RepositorioRestaurantes._internal();

  static List<Restaurante> listaRestaurantes = [];
  static String? campoBusca;

  List<Restaurante> getRestaurantes() {
    List<Restaurante> resultado = [];

    if (campoBusca != null) {
      resultado.addAll(listaRestaurantes
          .where((restaurante) => restaurante.nome.contains(campoBusca!)));
    } else {
      resultado.addAll(listaRestaurantes);
    }

    return resultado;
  }

  factory RepositorioRestaurantes() {
    //init();
    return _singleton;
  }

  RepositorioRestaurantes._internal();
}
