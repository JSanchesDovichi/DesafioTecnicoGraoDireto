import 'package:flutter/material.dart';
import 'package:front_end/Classes/restaurante.dart';
import 'package:front_end/DAO/restaurantes.dart';
import 'package:front_end/Utils/result.dart';

class ListaRestaurantes extends StatefulWidget {
  const ListaRestaurantes({super.key});

  @override
  State<ListaRestaurantes> createState() => _ListaRestaurantesState();
}

class _ListaRestaurantesState extends State<ListaRestaurantes> {
  @override
  Widget build(BuildContext context) {
    RestauranteDAO().buscarRestaurantes().then((resposta) => {
          switch (resposta) {
            Success<List<Restaurante>, Exception>(value: final token) => {
                print(token)
              },
            Failure<List<Restaurante>, Exception>(exception: final excecao) =>
              print("Ocorreu um erro: $excecao"),
          }
        });
    return const CircularProgressIndicator();
  }
}
