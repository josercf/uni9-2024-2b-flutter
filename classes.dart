void main() {
  Carro carroBryan = Carro(
      modelo: "Jetta", marca: "VW", chassi: "x123", fabricante: "Volks BR");

  carroBryan.ligar();
  carroBryan.parar();
  carroBryan.acelerar(5);
  carroBryan.acelerar(20);
  
  
  carroBryan.parar();
  //carroBryan.frear();
  carroBryan.desligar();

  Carro carroEster = Carro(
      modelo: "X6", marca: "BMW", chassi: "bmx62", fabricante: "BMW Alemanha");

  carroEster.ligar();
  carroEster.acelerar(10);
  carroEster.frear();
  carroEster.desligar();
}

class Carro {
  String modelo;
  String marca;
  String chassi;
  String fabricante;

  bool _ligado = false;
  int velocidade = 0;
  
  final int VELOCIDADE_MAX_PERMITIDA = 10;

  Carro({
    required this.modelo,
    required this.marca,
    required this.chassi,
    required this.fabricante,
  });

  void ligar() {
    this._ligado = true;
    print("Carro $modelo ligado! ${_ligado}");
  }

  void desligar() {
    this._ligado = false;
    velocidade = 0;
    print("Carro $modelo  desligado! ${_ligado}\t Velocidade: $velocidade");
  }

  void acelerar(int quantidade) {
    if (VerificarSeDentroDoLimite(quantidade)) {
      velocidade += quantidade;
      print("Carro  $modelo acelerando... velocidade: $velocidade");
    } else {
      print('Velocidade maior que o permitido. Velocidade atual: $velocidade');
    }
  }
  
  bool VerificarSeDentroDoLimite(int quantidade){
    return (velocidade + quantidade) < VELOCIDADE_MAX_PERMITIDA;
  }

  void frear() {
    velocidade--;
    print("Carro $modelo  freando... velocidade: $velocidade");
  }

  void parar() {
    print('Parar acionado');

    while (velocidade > 0) {
      frear();
    }
  }
}
