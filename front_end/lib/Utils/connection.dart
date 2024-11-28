// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:front_end/Utils/global_resources.dart';
import 'dart:convert';

const endpointurl = 'http://127.0.0.1:8000';

class Connection {
  static Connection _instance = Connection._internal();
  static final Dio handler = Dio(BaseOptions(baseUrl: endpointurl))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.extra["withCredentials"] = true;

          String? token = await Resources.storage.read(key: 'jwt_token');

          if (token != null) {
            options.headers["Authorization"] = token;
          }

          return handler.next(options);
        },
        //onError: (error, handler) => {print("SOMETHING WENT WRONG: ${error}")},
      ),
    );

  Connection._internal() {
    _instance = this;
  }

  factory Connection() => _instance;
}
