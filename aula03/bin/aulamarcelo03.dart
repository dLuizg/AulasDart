void main(List<String> arguments) {
  List<String> usuarios = ["Ana","Bruno","Carlos"];
  print(usuarios);

  //Mudança de um elemento
  usuarios[1] = "Bruna";
  print(usuarios);

  //Método de adição de valores
  usuarios.add("Daniel",);
  print(usuarios);

  //Método de inserção localizada, SEM alterar
  usuarios.insert(1, "Luiz");
  print(usuarios);

  //Método de remoção
  usuarios.remove("Luiz");
  print(usuarios);

  //Remover duplicados
  usuarios.add("Bruna");
  usuarios.remove("Bruna");
  print(usuarios);

  //Remover por POSIÇÃO
  usuarios.removeAt(2);
  print(usuarios);

  //Percorrer lista

  //FOR classico
  //for(inicializar variavel de controle; condição de parada da repetição V. de controle=Lenth; V. Controle++)
  for(int i=0;i<usuarios.length; i++){
    print(i+1);
    print("(FOR)Nome de usuário: ${usuarios[i]}");
  }

  //FOR - IN (For mais "simples" pra listas)
  for(var usuario in usuarios){
    print("(FORIN)Nome de usuário: $usuario");
  }

  //FOR EACH (Cada elemento da lista recebe uma função)
  usuarios.forEach((usuario){
    print("(EACH)Nome usuario: $usuario");
  });

  //Mapas e chaves
  Map<String,dynamic> sensor = {
    "Nome": "temperatura",
    "Unidade": "C",
    "Valor" : 25.5,
    "Ativo" : true
  };
  print(sensor);
  for(var key in sensor.keys){
    print("chave $key");
  }

  //Percorrer por valor (V)
  for(var value in sensor.values){
    print("valor:$value");
  }

  //Percorrer mapa ppor chave em valor
  for(var entry in sensor.entries){
    print("${entry.key} => ${entry.value}");
  }

  //For each para o map
  sensor.forEach((chave, valor){
    print("$chave => $valor");
  });

  //criar a lista de sensores
  List<Map<String,dynamic>> sensores [
    {"nome":"temp","un":"C","valor":22,"at":true},
    {"nome":"umid","un":"%","valor":70,"at":true},
    {"nome":"pressao","un":"hPa","valor":1003,"at":true}
  ];
  (sensores[1]['ativo']);
}
