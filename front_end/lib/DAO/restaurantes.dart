import 'package:dio/dio.dart';
import 'package:front_end/Classes/item_cardapio.dart';
import 'package:front_end/Classes/restaurante.dart';
import 'package:front_end/Utils/connection.dart';
import 'package:front_end/Utils/result.dart';

class RestauranteDAO {
  Future<Result<bool, Exception>> buscarRestaurantes() async {
    try {
      Response response = await Connection.handler.get('/restaurantes');

      List<Restaurante> listaRestaurantesEncontrados = [];

      if (response.statusCode == 200) {
        for (dynamic objeto in response.data) {
          Restaurante convertido = Restaurante.fromJson(objeto);
          listaRestaurantesEncontrados.add(convertido);
        }
      }

      RepositorioRestaurantes.listaRestaurantes.clear();
      RepositorioRestaurantes.listaRestaurantes
          .addAll(listaRestaurantesEncontrados);

      if (RepositorioRestaurantes.listaRestaurantes.isNotEmpty) {
        return const Success(true);
      } else {
        return const Success(false);
      }
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  Future<Result<bool, Exception>> buscarCardapio(int idRestaurante) async {
    try {
      Response response =
          await Connection.handler.get('/restaurantes/cardapio/$idRestaurante');

      List<ItemCardapio> listaCardapioEncontrada = [];

      if (response.statusCode == 200) {
        for (dynamic objeto in response.data) {
          ItemCardapio convertido = ItemCardapio.fromJson(objeto);
          listaCardapioEncontrada.add(convertido);
        }
      }

      RepositorioCardapio.listaItens.clear();
      RepositorioCardapio.listaItens.addAll(listaCardapioEncontrada);

      if (RepositorioCardapio.listaItens.isNotEmpty) {
        return const Success(true);
      } else {
        return const Success(false);
      }
    } on DioException catch (e) {
      print("Erro $e");
      return Failure(e);
    }
  }
}
