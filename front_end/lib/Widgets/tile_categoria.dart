import 'package:flutter/material.dart';
import 'package:front_end/Classes/restaurante.dart';
import 'package:front_end/Telas/detalhes_restaurante.dart';
import 'package:front_end/Utils/global_resources.dart';
import 'package:front_end/Widgets/transition.dart';

const double tileWidth = 150.0;

class TileCategoria extends StatelessWidget {
  const TileCategoria({super.key, required this.categoria});

  final String categoria;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          /*
          Navigator.of(context).push(DefaultRouteTransition(CardapioRestaurante(
            idRestaurante: restaurante.id,
          )));
          */
        },
        child: Stack(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                  height: 100.0,
                  width: tileWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          categoria,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          //style: Theme.of(context).textTheme.subhead,
                        ),
                        //Text("bar")
                      ],
                    ),
                  )),
            ),
            Positioned(
              top: .0,
              left: .0,
              right: .0,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), //or 15.0
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: Color(0xffFF0E58),
                    child:
                        Icon(Icons.volume_up, color: Colors.white, size: 30.0),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
