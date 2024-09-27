import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> foods = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  // Función para obtener los datos del API de Django
  Future<void> fetchFoods() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.111.123:8000/api/foods/'), // Cambia a tu IP/URL
      );

      if (response.statusCode == 200) {
        setState(() {
          // Asumimos que la estructura es un array de objetos
          foods = json.decode(response.body) ?? [];
        });
      } else {
        throw Exception(
            'Error al obtener los alimentos. Código: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar platillos...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: foods.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  // Extraemos los datos relevantes de cada alimento
                  final title = foods[index]['title'] ?? 'Título no disponible';
                  final description = foods[index]['description'] ??
                      'Descripción no disponible';
                  final price = foods[index]['price']?.toString() ??
                      'Precio no disponible';
                  final imageUrl = foods[index]['image'] ??
                      'https://via.placeholder.com/150'; // URL por defecto

                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      leading: Image.network(
                        imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(description),
                          const SizedBox(height: 5),
                          Text('$price MXN',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menú',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Órdenes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Banquetes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: 0, // Puedes cambiar el índice activo según lo necesites
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Implementa la navegación al presionar los íconos
        },
      ),
    );
  }
}
