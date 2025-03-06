import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wvjzrcwwxhdigsazxgzk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind2anpyY3d3eGhkaWdzYXp4Z3prIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEyMjA2NDQsImV4cCI6MjA1Njc5NjY0NH0.1s0g-t5ByTWQHA46BT4JXB8bXWLjohZ6ZdW718O8He0',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema Bancario',
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

  String Seleccion = 'Seleccione';

  void toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
      _menuWidth = _showMenu ? 200 : 0;
    });
  }

  // Lista de etiquetas de personas
  final List<Map<String, String>> etiquetas = [
    {"nombre": "Juan Pérez", "tipo": "Cliente frecuente"},
    {"nombre": "María López", "tipo": "Cliente nuevo"},
    {"nombre": "Carlos Gómez", "tipo": "Cliente VIP"},
    {"nombre": "Ana Torres", "tipo": "Cliente registrado desde 2020"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF4E332E),
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(20)),
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
                                  hint: Text(Seleccion),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                        value: 'Préstamos',
                                        child: Text('Préstamos')),
                                    DropdownMenuItem(
                                        value: 'Inversión',
                                        child: Text('Inversión')),
                                    DropdownMenuItem(
                                        value: 'Seguros',
                                        child: Text('Seguros')),
                                  ],
                                  onChanged: (value) {
                                    Seleccion = value.toString();
                                  },
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
                                    title: Text(
                                      etiquetas[index]['nombre']!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(etiquetas[index]['tipo']!),
                                    onTap: () => mostrarOpcionesPago(
                                        context, etiquetas[index]['nombre']!),
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

              // ----------------- MENÚ DESLIZANTE (DERECHA) -----------------
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _menuWidth,
                height: double.infinity,
                color: Color.fromARGB(255, 82, 59, 59),
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
            ],
          ),
        ],
      ),
    );
  }

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
              exit(0);
            },
          ),
        ],
      ),
    );
  }

  void mostrarOpcionesPago(BuildContext context, String nombre) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Opciones de pago para $nombre"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Depósito a cuenta"),
              onTap: () {
                Navigator.pop(context);
                ingresarMonto(context, nombre, "Depósito a cuenta", true);
              },
            ),
            ListTile(
              title: Text("Pago de préstamo"),
              onTap: () {
                Navigator.pop(context);
                ingresarMonto(context, nombre, "Pago de préstamo", false);
              },
            ),
            ListTile(
              title: Text("Pago de inversión"),
              onTap: () {
                Navigator.pop(context);
                ingresarMonto(context, nombre, "Pago de inversión", false);
              },
            ),
            ListTile(
              title: Text("Pago de seguro"),
              onTap: () {
                Navigator.pop(context);
                ingresarMonto(context, nombre, "Pago de seguro", false);
              },
            ),
          ],
        ),
      ),
    );
  }

  void ingresarMonto(
      BuildContext context, String nombre, String tipo, bool editable) {
    TextEditingController montoController = TextEditingController();

    if (!editable) {
      // Si no es editable, asignamos un monto predefinido (ejemplo)
      montoController.text = tipo == "Pago de préstamo"
          ? "3200"
          : tipo == "Pago de inversión"
              ? "10000"
              : "800"; // Pago de seguro
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ingrese el monto"),
        content: TextField(
          controller: montoController,
          keyboardType: TextInputType.number,
          enabled: editable, // Solo editable si es depósito
          decoration: InputDecoration(labelText: "Monto en \$"),
        ),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Confirmar"),
            onPressed: () {
              // Aquí puedes enviar el monto ingresado a la base de datos o procesarlo
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
