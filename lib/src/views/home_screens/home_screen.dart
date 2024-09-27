import 'package:flutter/material.dart';
import 'package:rest_app_movil/src/views/shared/layout.dart';
import 'package:rest_app_movil/src/providers/foods_api_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> foods = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  Future<void> fetchFoods() async {
    try {
      final FoodsApiProvider foodsApiProvider = FoodsApiProvider();
      final List<dynamic> fetchedFoods = await foodsApiProvider.fetchFoods();
      setState(() {
        foods = fetchedFoods;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        content: Center(
      child: foods.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                // Extraemos los datos relevantes de cada alimento
                final title = foods[index]['title'] ?? 'Título no disponible';
                final description =
                    foods[index]['description'] ?? 'Descripción no disponible';
                final price =
                    foods[index]['price']?.toString() ?? 'Precio no disponible';
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
    ));
  }
}
