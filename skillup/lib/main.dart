import 'package:flutter/material.dart';
import 'package:skillup/pages/cadastro.dart';
import 'package:skillup/pages/login.dart';
import 'package:skillup/pages/perf_adm.dart';

void main() {
runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: "/",
  routes: {
   "/": (context) => const Login(),
   "/EditAdm":(context) => const EditAdm(),
   "/Cadastro":(context) => const Cadastro()
  },
  
));
}