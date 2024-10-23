import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

// Modelo para a previsão do tempo
class Previsao {
  final String data;
  final double temperatura;
  final double umidade;
  final double luminosidade;
  final double vento;
  final double chuva;
  final String unidade;

  Previsao({
    required this.data,
    required this.temperatura,
    required this.umidade,
    required this.luminosidade,
    required this.vento,
    required this.chuva,
    required this.unidade,
  });

  factory Previsao.fromJson(Map<String, dynamic> json) {
    return Previsao(
      data: json['data'],
      temperatura: json['temperatura'],
      umidade: json['umidade'],
      luminosidade: json['luminosidade'],
      vento: json['vento'],
      chuva: json['chuva'],
      unidade: json['unidade'],
    );
  }
}

void main() {
  runApp(PrevisaoApp());
}

class PrevisaoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do Tempo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrevisaoPage(),
    );
  }
}

class PrevisaoPage extends StatefulWidget {
  @override
  _PrevisaoPageState createState() => _PrevisaoPageState();
}

class _PrevisaoPageState extends State<PrevisaoPage> {
  late Future<List<Previsao>> previsoes;
  Previsao? previsaoSelecionada;

  @override
  void initState() {
    super.initState();
    previsoes = fetchPrevisao();
  }

  // Função para buscar as previsões do endpoint
  Future<List<Previsao>> fetchPrevisao() async {
    final response =
        await http.get(Uri.parse('https://demo3520525.mockable.io/previsao'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Previsao.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar a previsão do tempo');
    }
  }

  // Função para formatar a data e trazer o nome do dia da semana
  String obterNomeDoDia(String data) {
    DateTime date = DateTime.parse(data);
    return "${date.day}/${date.month}";
  }

  // Função para definir o ícone com base na quantidade de chuva
  IconData obterIconeChuva(double chuva) {
    if (chuva == 0.0) {
      return Icons.wb_sunny;
    } else if (chuva > 0 && chuva <= 20) {
      return Icons.wb_cloudy;
    } else if (chuva > 20 && chuva <= 40) {
      return Icons.cloud;
    } else {
      return Icons.grain; // Nuvens com chuva
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previsão do Tempo'),
      ),
      body: FutureBuilder<List<Previsao>>(
        future: previsoes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Previsao> listaPrevisoes = snapshot.data!;
            return Column(
              children: [
                // Carrossel para os dias
                CarouselSlider.builder(
                  itemCount: listaPrevisoes.length,
                  options: CarouselOptions(
                    height: 100.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    Previsao previsao = listaPrevisoes[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          previsaoSelecionada = previsao;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            obterIconeChuva(previsao.chuva),
                            size: 40,
                          ),
                          SizedBox(height: 10),
                          Text(obterNomeDoDia(previsao.data)),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                // Exibir detalhes do dia selecionado
                previsaoSelecionada != null
                    ? Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Data: ${previsaoSelecionada!.data}'),
                              Text(
                                  'Temperatura: ${previsaoSelecionada!.temperatura}°${previsaoSelecionada!.unidade}'),
                              Text('Umidade: ${previsaoSelecionada!.umidade}%'),
                              Text(
                                  'Luminosidade: ${previsaoSelecionada!.luminosidade} lux'),
                              Text('Vento: ${previsaoSelecionada!.vento} m/s'),
                              Text('Chuva: ${previsaoSelecionada!.chuva} mm'),
                            ],
                          ),
                        ),
                      )
                    : Center(child: Text('Selecione um dia no carrossel')),
              ],
            );
          } else {
            return Center(child: Text('Nenhuma previsão disponível.'));
          }
        },
      ),
    );
  }
}
