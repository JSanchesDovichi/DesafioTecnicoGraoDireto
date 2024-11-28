import 'package:dio/dio.dart';
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

      //return Success(listaRestaurantesEncontrados);
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
}
