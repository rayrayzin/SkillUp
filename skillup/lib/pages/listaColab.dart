import 'package:flutter/material.dart';
import 'package:skillup/style/colors.dart';

class ListaColab extends StatefulWidget {
  const ListaColab({super.key});

  @override
  State<ListaColab> createState() => _ListaColabState();
}

class _ListaColabState extends State<ListaColab>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _colaboradores = ['Julia', 'Leticia', 'Ana', 'Júlia'];
  List<String> _filteredColaboradores = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filteredColaboradores = List.from(_colaboradores);

    _searchController.addListener(() {
      setState(() {
        _filteredColaboradores = _colaboradores
            .where((colaborador) => colaborador
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Buscar colaborador',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                    ),
                  ),
                ),
                Image.asset('images/logop.png'),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                color: Color(0xFF2282FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: 'Colaboradores'),
                Tab(text: 'Administrador'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildColaboradorList(),
                const Center(child: Text('Lista de Administradores')),
              ],
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

  Widget _buildColaboradorList() {
    return ListView.builder(
      itemCount: _filteredColaboradores.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_filteredColaboradores[index]),
        );
      },
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
                Navigator.of(context).pushNamed("/Treinamento");
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
