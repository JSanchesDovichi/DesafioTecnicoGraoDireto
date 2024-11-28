import 'package:dio/dio.dart';
import 'package:front_end/Utils/connection.dart';
import 'package:front_end/Utils/result.dart';

class RestauranteDAO {
  Future<Result<String, Exception>> buscarRestaurantes() async {
    try {
      Response response = await Connection.handler.get('/restaurantes');

      return Success(response.data);
    } on DioException catch (e) {
      return Failure(e);
    }
  }
}
