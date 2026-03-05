import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  // Scaffoldmessenger que se encarga de mostrar los snackbar
  ScaffoldMessenger.of(context)
    // este metodo se encarga de ocultar el snackbar actual
    ..hideCurrentSnackBar()
    // este metodo se encarga de mostrar el snackbar
    ..showSnackBar(SnackBar(content: Text(text)));
}
