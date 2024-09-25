import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

//A classe home vai gerenciar o estado da nossa aplicação:
//A tela em execução e os valores dos campos
class Home extends StatefulWidget {
//Utilizamos o override para
//sobrescrever o comportamento de criação da nossa aplicação
  @override
  _HomeState createState() => _HomeState();
}

//Esta classe representa a nossa view
//ela extende o Estado da aplicação que criamos anteriormente
class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = "****";

  void _reset() {
    alcoolController.text = "";
    gasolinaController.text = "";

    setState(() {
      _resultado = "****";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularCombustivelIdeal() {
    setState(() {
      double vlrAlcool =
          double.parse(alcoolController.text.replaceAll(',', '.'));
      double vlrGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));

      double proporcao = vlrAlcool / vlrGasolina;
      _resultado =
          proporcao < 0.7 ? "Abasteça com Álcool" : "Abasteça com Gasolina";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Álcool ou Gasolina?",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                _reset();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 150.0,
                color: Colors.lightBlue[900],
              ),
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o valor do Álcool";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Valor do Álcool",
                    labelStyle: TextStyle(color: Colors.lightBlue[900])),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
              ),
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o valor da Gasolina";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Valor da Gasolina",
                    labelStyle: TextStyle(color: Colors.lightBlue[900])),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Container(
                      height: 50.0,
                      child: ElevatedButton(
                        child: Text("Calcule",
                            style:
                                TextStyle(color: Colors.white, fontSize: 26.0)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[900]),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calcularCombustivelIdeal();
                          }
                        },
                      ))),
              Text(_resultado,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 26.0))
            ],
          ),
        ),
      ),
    );
  }
}
