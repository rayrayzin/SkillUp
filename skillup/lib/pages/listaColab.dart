import 'package:flutter/material.dart';
import 'package:skillup/style/colors.dart';

class ListaColab extends StatefulWidget {
  const ListaColab({super.key});

  @override
  State<ListaColab> createState() => _ListaColabState();
}

class _ListaColabState extends State<ListaColab> with SingleTickerProviderStateMixin {
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
            .where((colaborador) => colaborador.toLowerCase().contains(_searchController.text.toLowerCase()))
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
                        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: branco,
                        labelText: 'Buscar colaborador',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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
              dividerColor: Colors.white,
              indicatorPadding: const EdgeInsets.only(left: 8.0, right: 8.0),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                _buildTab('Colaboradores', 0),
                _buildTab('Administrador', 1),
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
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

  Widget _buildTab(String label, int index) {
    final isSelected = _tabController.index == index;

    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2282FF) : const Color(0xFF002657),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
      ),
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
              accountEmail: Text("Administrador", style: TextStyle(color: Colors.white70)),
            ),
            ListTile(
              title: const Text('Lista de colaboradores', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle drawer option tap
              },
            ),
            ListTile(
              title: const Text('Lista de treinamentos', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle drawer option tap
              },
            ),
          ],
        ),
      );
}
