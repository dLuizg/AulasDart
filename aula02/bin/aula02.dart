void main(List<String> arguments) {

  //Array
  List<int> numeros= [10,20,30,40];

  print(numeros[2]);//20
  print(numeros[1]);//30
  print(numeros); //[10, 20, 30, 40]
  
  
  List<String> alunos = ["João","Maria","Renata"];
  print(alunos);//["João","Maria","Renata"]
  String aluno = alunos[0];
  alunos[0] = "José";
  print(alunos);
  print(aluno);

  //Lista - operações
  //declarar lista vazia
  List<int> numbers = [];
  //declarar lista com elementos
  List<String> names = ["Ana","Breno","Carlos"];
  print(names[1]);
  //adicionar
  names.add("Daniel");
  print(names);
  //remover
  bool removeu = names.remove(names[2]);
  print (names);
  print (removeu);
  removeu = names.remove("Daniela");
  print(removeu);

  List<String> sensores = ["temp","ldr","temp","gas"];
  bool removido = sensores.remove("temp");
  print(removido);
  print(sensores);

  //tamanho da lista
  print(sensores.length);
  
  //Mapa
  Map<String, dynamic> sensors = {
    "nome" : "temperatura",
    "valor":22.5,
    "unidade":"C",
    "ativo": true
  };
  sensors["valor"]=23.5;
} 