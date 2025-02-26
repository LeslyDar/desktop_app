import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController text = TextEditingController();
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170), // Altura personalizada
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF4E332E), // Color marrón oscuro
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Primera línea: Información de ventanilla y sesión
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ventanilla no. 4",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "Matrícula: 102346501",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          "Sesión: Fulanito Detal",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10), // Espaciado

                // Segunda línea: Campos de búsqueda y filtro
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: text,
                        decoration: InputDecoration(
                          hintText:
                              "Ingrese el nombre o código de identificación del usuario",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Filtrado:",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 150,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Option 1',
                            child: Text('Option 1'),
                          ),
                          DropdownMenuItem(
                            value: 'Option 2',
                            child: Text('Option 2'),
                          ),
                          DropdownMenuItem(
                            value: 'Option 3',
                            child: Text('Option 3'),
                          ),
                        ],
                        onChanged: (value) {
                          // Handle change
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            color: const Color(0xFFB1ACAC),
            child: Center(
              child: Text(
                'Hola Mundo',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
