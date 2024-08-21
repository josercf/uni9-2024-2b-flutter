void main() {
  double nota = 7;
  int faltas = 8;

  //< 5: REPROVADO
  //Entre 5 e 7 RECUPERAÇÃO
  //> 7: Aprovado

  if (nota < 5) {
    print("Reprovado");
  } else if (nota < 7) {
    print("Recuperação");
  } else {
    print("Aprovado");
  }

  if (nota < 5) {
    print("If statement: Reprovado");
  } else {
    print("If statement: Aprovado");
  }

  //Exemplo de ternário

  String info = nota < 5 ? "Reprovado" : "Aprovado";
  print("Resultado do ternário: $info");

  print("***************************************");
  print("**************SWITCH*******************");
  print("***************************************");
  String botao = "Y";

  switch (botao) {
    case "X":
      print("Pular");
      break;
    case "Y":
      print("Agachar");
      break;
    case "B":
      print("Atirar");
      break;
    case "A":
      print("Bater");
      break;
    default:
      print("botão inexistente!");
      break;
  }

  print("***************************************");
  print("**************for*******************");
  print("***************************************");

  for (int i = 0; i < 10; i++) {
    print("O valor de i é: $i");
  }

  print("Fim do processamento");
}
