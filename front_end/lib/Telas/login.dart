import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_end/DAO/Usuario.dart';
import 'package:front_end/Telas/detalhes_restaurante.dart';
import 'package:front_end/Telas/dashboard.dart';
import 'package:front_end/Utils/Crypto.dart';
import 'package:front_end/Utils/global_resources.dart';
import 'package:front_end/Utils/result.dart';
import 'package:front_end/Widgets/input.dart';
import 'package:front_end/Widgets/transition.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final chaveIdentificacaoForm = GlobalKey<FormState>();

    final controllerCaixaEmail = TextEditingController();
    final controllerCaixaSenha = TextEditingController();

    verificarTokenERedirecionar(String token) async {
      await Resources.storage.write(key: 'jwt_token', value: token);

      if (await Resources.storage.read(key: 'jwt_token') != null) {
        //context.go('/restaurantes');
        Navigator.of(context).push(DefaultRouteTransition(Dashboard()));
      }
    }

    /*
    verificarResposta(Response? resposta) async {
      if (resposta != null && resposta.statusCode == 200) {
        await Resources.storage
            .write(key: 'jwt_token', value: resposta.data["token"]);

        if (await Resources.storage.read(key: 'jwt_token') != null) {
          //Resources.navigatorKey.currentContext!.go('/restaurantes');
          context.go('/restaurantes');
        }
      } else {
        //TODO: Mostrar erro!
        /*
        dialogAlerta(
          titulo: const Text(
            "Erro de autenticação:",
          ),
          conteudo: const Text(
            "Não foi possível acessar o sistema\ncom as informações inseridas.",
          ),
          acoes: [Widgets.botaoVoltar(dialog: true)],
        );
        */
      }
    }
    */

    enviarDadosLogin() async {
      //pega os dados da struct map

      if (chaveIdentificacaoForm.currentState!.validate()) {
        String email = controllerCaixaEmail.text.trimRight();
        String senha = controllerCaixaSenha.text;
        if (email.isNotEmpty && senha.isNotEmpty) {
          FormData test = FormData.fromMap({
            "username": Crypto.sha512encode(email),
            "password": Crypto.sha512encode(senha),
          });
          UsuarioDAO().login(test).then((resposta) async => {
                switch (resposta) {
                  Success<String, Exception>(value: final token) => {
                      await verificarTokenERedirecionar(token)
                    },
                  Failure<String, Exception>(exception: final excecao) =>
                    print("Ocorreu um erro: $excecao"),
                }
              });
        }
      }
    }

    Widget caixaEmail = caixaInput(
        controlador: controllerCaixaEmail,
        icone: const Icon(Icons.email),
        labelText: 'Insira seu email',
        hintText: 'Email',
        obscureText: false,
        readOnly: false);

    Widget caixaSenha = caixaInput(
        controlador: controllerCaixaSenha,
        icone: const Icon(Icons.password),
        hintText: 'Insira sua senha',
        labelText: 'Senha',
        obscureText: true,
        readOnly: false);

    return MaterialApp(
      theme: Resources.themeData,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Switch.adaptive(
                activeColor: Colors.green.shade100,
                value: Resources.isDark,
                onChanged: (value) {
                  setState(() {
                    Resources.isDark = value;

                    Resources.setThemeData();
                  });
                }),
          ),
          body: Center(
              child: Form(
                  key: chaveIdentificacaoForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Textos.tituloPagina('Entrar'),
                      Text(
                        "Bem vindo de volta!",
                        style: GoogleFonts.poppins(fontSize: 30),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                      ),
                      caixaEmail,
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      caixaSenha,
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: enviarDadosLogin,

                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                  Colors.green.shade600)),
                          //style: estiloBotaoGrande(),

                          child: Text(
                            'Acessar!',
                            style: GoogleFonts.poppins(
                                color: Resources.themeData.indicatorColor),
                            /*
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Temas.temaAtual().scaffoldBackgroundColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)
                          )*/
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 4)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Não tem uma conta?',
                            style: TextStyle(
                              fontSize: 16,
                              //color: Temas.temaAtual().hintColor
                            ),
                          ),
                          const SizedBox(
                            width: 0,
                          ),
                          TextButton(
                            onPressed: null,
                            child: Text(
                              'Inscreva-se',
                              //style: Temas.estiloTextoPequeno()
                            ),
                          )
                        ],
                      ),
                    ],
                  )))),
    );
  }
}
