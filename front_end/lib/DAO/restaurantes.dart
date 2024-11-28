import 'package:dio/dio.dart';
import 'package:front_end/Classes/restaurante.dart';
import 'package:front_end/Utils/connection.dart';
import 'package:front_end/Utils/result.dart';

class RestauranteDAO {
  Future<Result<List<Restaurante>, Exception>> buscarRestaurantes() async {
    try {
      Response response = await Connection.handler.get('/restaurantes');

      List<Restaurante> listaRestaurantesEncontrados = [];

      if (response.statusCode == 200) {
        for (dynamic objeto in response.data) {
          Restaurante convertido = Restaurante.fromJson(objeto);
          listaRestaurantesEncontrados.add(convertido);
        }
      }

      return Success(listaRestaurantesEncontrados);
    } on DioException catch (e) {
      return Failure(e);
    }
  }
}
