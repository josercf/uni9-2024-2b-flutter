void main() {
  double nota = 7;
  int faltas = 11;

  
  //< 5: REPROVADO
  //Entre 5 e 7 RECUPERAÇÃO
  //> 7: Aprovado
  
  if (nota < 5) {
    print("Reprovado");
  } else if(nota < 7){
    print("Recuperação");
  }  else {
    print("Aprovado");
  }

  print("Fim do processamento");
}