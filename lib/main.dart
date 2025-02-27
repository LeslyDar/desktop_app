import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showMenu = false;
  double _menuWidth = 0;

  void toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
      _menuWidth = _showMenu ? 200 : 0;
    });
  }

  // Lista de etiquetas de personas
  final List<Map<String, String>> etiquetas = [
    {"nombre": "Juan Pérez", "info": "Cliente frecuente, tiene 5 compras."},
    {"nombre": "María López", "info": "Cliente nuevo, primera compra."},
    {"nombre": "Carlos Gómez", "info": "Cliente VIP, historial de 10 compras."},
    {"nombre": "Ana Torres", "info": "Cliente registrado desde 2020."},
  ];

  // Método para mostrar la ventana flotante con información
  void mostrarInformacion(
      BuildContext context, String titulo, String contenido) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(contenido),
        actions: [
          TextButton(
            child: Text("Cerrar"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // ----------------- MENÚ DESLIZANTE (IZQUIERDA) -----------------
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _menuWidth,
                height: double.infinity,
                color: Color.fromARGB(255, 100, 94, 94),
                child: _showMenu
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Menú",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            Divider(),
                            TextButton(
                              onPressed: () => _confirmLogout(context),
                              child: Text("Cerrar Sesión",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ),

              // ----------------- CUERPO PRINCIPAL -----------------
              Expanded(
                child: Column(
                  children: [
                    // ----------------- APP BAR -----------------
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF4E332E),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(20)),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ventanilla no. 4",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  Text("Matrícula: 102346501",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ],
                              ),
                              Text("Sesión: Fulanito Detal",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText:
                                        "Ingrese el nombre o código de identificación",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("Filtrado:",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              SizedBox(width: 10),
                              Container(
                                width: 150,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                        value: 'Option 1',
                                        child: Text('Option 1')),
                                    DropdownMenuItem(
                                        value: 'Option 2',
                                        child: Text('Option 2')),
                                    DropdownMenuItem(
                                        value: 'Option 3',
                                        child: Text('Option 3')),
                                  ],
                                  onChanged: (value) {},
                                ),
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(Icons.menu, color: Colors.white),
                                onPressed: toggleMenu,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ----------------- CONTENIDO (Etiquetas) -----------------
                    Expanded(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          color: const Color(0xFFB1ACAC),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: ListView.builder(
                              itemCount: etiquetas.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    title: Text(etiquetas[index]['nombre']!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(etiquetas[index]['info']!),
                                    onTap: () => mostrarInformacion(
                                        context,
                                        etiquetas[index]['nombre']!,
                                        etiquetas[index]['info']!),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------- CONFIRMAR CIERRE DE SESIÓN -----------------
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cerrar Sesión"),
        content: Text("¿Estás seguro de que deseas cerrar sesión?"),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Salir", style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
              toggleMenu();
            },
          ),
        ],
      ),
    );
  }
}
