import 'dart:io';

void main() {
  bool calcularProximaNota = true;

  while (calcularProximaNota) {
    
    String nomeAluno = coletarNomeAluno();
    double notaCheckpoint = coletarNotaCheckpoint();
    double notaProva = coletarNotaProva();

    double av1 = calcularAv1(notaCheckpoint, notaProva);
    print('A nota av1  do aluno ${nomeAluno} é ${av1}');

    print('Deseja calcular a média de outro aluno? (S/N)');
    String resposta = stdin.readLineSync()!;

    calcularProximaNota = resposta == 'S' || resposta == 's';
  }
}

String coletarNomeAluno() {
  print('Digite o nome do aluno:');
  String nomeAluno = stdin.readLineSync()!;
  return nomeAluno;
}

double coletarNotaCheckpoint() {
  print('Digite a nota do checkpoint:');
  double notaCheckpoint = double.parse(stdin.readLineSync()!);
  return notaCheckpoint;
}

double coletarNotaProva() {
  print('Digite a nota da prova:');
  double notaProva = double.parse(stdin.readLineSync()!);
  return notaProva;
}

double calcularAv1(double notaCheckpoint, double notaProva) {
  const double pesoCheckpoint = 0.4;
  const double pesoProva = 0.6;

  double av1 = notaCheckpoint * pesoCheckpoint + notaProva * pesoProva;
  return av1;
}
