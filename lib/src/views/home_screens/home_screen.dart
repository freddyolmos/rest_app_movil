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
  List<dynamic> topFoods = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFoods();
    fetchTopSellingFoods();
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

  Future<void> fetchTopSellingFoods() async {
    try {
      final TopSellingFoodsApiProvider topSellingFoods =
          TopSellingFoodsApiProvider();
      final List<dynamic> fetchedTopFoods =
          await topSellingFoods.fetchTopSellingFoods();
      setState(() {
        topFoods = fetchedTopFoods;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      content: Center(
        child: topFoods.isEmpty
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 200, // Ajusta la altura según sea necesario
                child: ListView.builder(
                  scrollDirection:
                      Axis.horizontal, // Habilita el desplazamiento horizontal
                  itemCount: topFoods.length,
                  itemBuilder: (context, index) {
                    // Extraemos los datos relevantes de cada alimento
                    final title =
                        topFoods[index]['title'] ?? 'Título no disponible';
                    final description = topFoods[index]['description'] ??
                        'Descripción no disponible';
                    final price = topFoods[index]['price']?.toString() ??
                        'Precio no disponible';
                    final imageUrl = topFoods[index]['image'] ??
                        'https://via.placeholder.com/150'; // URL por defecto

                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        // Usar un Container para controlar el ancho del Card
                        width: 400, // Ajusta el ancho según sea necesario
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
