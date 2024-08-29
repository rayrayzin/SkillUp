import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treinamentos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TreinamentoPage(),
    );
  }
}

class TreinamentoPage extends StatefulWidget {
  const TreinamentoPage({super.key});

  @override
  State<TreinamentoPage> createState() => _TreinamentoPageState();
}

class _TreinamentoPageState extends State<TreinamentoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _treinamentos = ['Treinamento 1', 'Treinamento 2', 'Treinamento 3'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 110, 203, 224),
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isLargeScreen
                    ? _buildUserAccountInfo()
                    : IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            _scaffoldKey.currentState?.openDrawer(),
                      ),
                const Text(
                  'Treinamentos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset('images/logop.png'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/CriaTreinamento");
                setState(() {
                  _treinamentos.add('Novo Treinamento');
                });
              },
              child: const Text('Adicionar Treinamento'),
            ),
          ),
        ],
      ),
      drawer: isLargeScreen ? null : _drawer(),
    );
  }

  Widget _buildUserAccountInfo() {
    return const Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: Color.fromRGBO(50, 64, 82, 1)),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Julia",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "Administrador",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  Widget _drawer() => Drawer(
        backgroundColor: const Color.fromRGBO(50, 64, 82, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color.fromRGBO(50, 64, 82, 1)),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(50, 64, 82, 1),
              ),
              accountName: Text("Julia", style: TextStyle(color: Colors.white)),
              accountEmail: Text("Administrador",
                  style: TextStyle(color: Colors.white70)),
            ),
            ListTile(
              title: const Text('Lista de colaboradores',
                  style: TextStyle(color: Colors.white)),
              onTap: () {

              },
            ),
            ListTile(
              title: const Text('Lista de treinamentos',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
              },
            ),
            const SizedBox(height: 450),
            ListTile(
              title: const Text('Sair',
                  style: TextStyle(color: Color.fromARGB(255, 224, 66, 66))),
              onTap: () {
                 Navigator.of(context).pushNamed("/");
              },
            ),
          ],
        ),
      );
}
