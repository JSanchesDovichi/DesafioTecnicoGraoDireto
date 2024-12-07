import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/Utils/global_resources.dart';
import 'package:google_fonts/google_fonts.dart';

Widget caixaInput(
    {required TextEditingController controlador,
    required Icon icone,
    required String hintText,
    required String labelText,
    required bool obscureText,
    required bool readOnly,
    String? suffixText,
    String? counterText,
    List<TextInputFormatter>? formatters,
    int? maxLength,
    Function? onChanged,
    Function? onTap}) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 350),
    child: TextFormField(
        style: GoogleFonts.poppins(color: Resources.themeData.indicatorColor),
        obscureText: obscureText,
        readOnly: readOnly,
        controller: controlador,
        inputFormatters: formatters,
        decoration: InputDecoration(
            floatingLabelStyle: GoogleFonts.poppins(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    //color: Colors.black12,
                    color: Resources.themeData.highlightColor,
                    /*
                    color: Resources.isDarkModeEnabled == true
                        ? Temas.temaAtual().secondaryHeaderColor
                        : Colors.black12,
                        */
                    width: 2)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Resources.themeData.highlightColor,
                    /*
                    color: Resources.isDarkModeEnabled == true
                        ? Temas.temaAtual().primaryColor
                        : Colors.black,
                        */
                    width: 2)),
            //icon: Icon(Icons.),
            //labelStyle: TextStyle(color: Temas.temaAtual().primaryColor),
            prefixIcon: icone,
            hintText: hintText,
            labelText: labelText,
            //labelStyle: TextStyle(color: Temas.temaAtual().primaryColor),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixText: suffixText,
            counterText: counterText),
        maxLength: maxLength,
        onChanged: (value) => {if (onChanged != null) onChanged(value)},
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Campo obrigatório!';
          }
          return null;
        }),
  );
}
