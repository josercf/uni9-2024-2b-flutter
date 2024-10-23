import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonScreen(),
    );
  }
}

class PokemonScreen extends StatefulWidget {
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  // Variáveis para armazenar as informações do Pokémon
  String _pokemonName = '';
  String _pokemonImageUrl = '';
  int _pokemonId = 0;
  double _pokemonHeight = 0;
  double _pokemonWeight = 0;
  List<String> _pokemonTypes = [];
  List<String> _pokemonAbilities = [];

  // Função para buscar os dados da API
  Future<void> fetchPokemonData(String pokemonName) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _pokemonName = data['name'];
        _pokemonImageUrl = data['sprites']['front_default'];
        _pokemonId = data['id'];
        _pokemonHeight = data['height'] / 10; // Convertido para metros
        _pokemonWeight = data['weight'] / 10; // Convertido para kg
        _pokemonTypes = (data['types'] as List)
            .map((typeInfo) => typeInfo['type']['name'].toString())
            .toList();
        _pokemonAbilities = (data['abilities'] as List)
            .map((abilityInfo) => abilityInfo['ability']['name'].toString())
            .toList();
      });
    } else {
      // Caso ocorra um erro, mostrar uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar dados do Pokémon')),
      );
    }
  }

  final _pokemonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pokemonController,
              decoration: InputDecoration(
                labelText: 'Digite o nome do Pokémon',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                fetchPokemonData(_pokemonController.text.toLowerCase());
              },
              child: Text('Buscar Pokémon'),
            ),
            SizedBox(height: 20),
            if (_pokemonName.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(_pokemonImageUrl),
                      SizedBox(height: 10),
                      Text(
                        'Nome: $_pokemonName',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ID: $_pokemonId',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Altura: ${_pokemonHeight.toStringAsFixed(1)} metros',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Peso: ${_pokemonWeight.toStringAsFixed(1)} kg',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Tipos:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        children: _pokemonTypes
                            .map((type) => Chip(
                                  label: Text(type),
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Habilidades:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        children: _pokemonAbilities
                            .map((ability) => Chip(
                                  label: Text(ability),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
