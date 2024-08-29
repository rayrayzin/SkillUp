import 'package:flutter/material.dart';
import 'package:skillup/pages/cadastro.dart';
import 'package:skillup/pages/criaTreina.dart';
import 'package:skillup/pages/curso.dart';
import 'package:skillup/pages/listaColab.dart';
import 'package:skillup/pages/login.dart';
import 'package:skillup/pages/perf_adm.dart';
import 'package:skillup/pages/treinamentos.dart';

void main() {
runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: "/",
  routes: {
   "/": (context) => const Login(),
   "/EditAdm":(context) => const EditAdm(),
   "/Cadastro":(context) => const Cadastro(),
   "/Lista":(context) => const ListaColab(),
   "/Curso":(context) => const Curso(),
   "/Treinamento":(context) => const TreinamentoPage(),
   "/CriaTreinamento":(context) => const CriaTreinamento(),
  },
));
}