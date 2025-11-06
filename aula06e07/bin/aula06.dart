//Código das 3 últimas aulas: 22/10, 29/10 e 05/1

import 'dart:math';

final aleatorio = Random();

//Manipulação da String no terminal

String pad(String s, int w) => 
  (s.length >= w) //Sim, é um if 
  ? s.substring(0, w) // Agora o : é else
  : s+'' * (w - s.length);

//Formatador de casas decimais
String fmt(num x, {frac = 1}) => x.toStringAsFixed(frac);

//Extração de número do map de forma segura

double asDouble(Map<String, dynamic> m, String k) => (m[k] as num).toDouble();

//Modelar sensores com estado Inicial
final List<Map<String, dynamic>> sensores = [
  {
   'nome' : 'Temperatura',
   'undade' : 'C',
   'valor' : 26.0,
   'min' : 18.0,
   'max' : 30.0,
   'ativo' : true,
   'critico' : false,
   'estado' : 'OK',
  },
  {
   'nome' : 'Umidade',
   'undade' : '%',
   'valor' : 55.0,
   'min' : 35.0,
   'max' : 75,
   'ativo' : true,
   'critico' : false,
   'estado' : 'OK',
  },
  {
   'nome' : 'Pressão',
   'undade' : 'hPa',
   'valor' : 1013.0,
   'min' : 990.0,
   'max' : 1030.0,
   'ativo' : true,
   'critico' : false,
   'estado' : 'OK',
  },
  {
    'nome' : 'Luz',
    'undade' : 'lm',
    'valor' : 400.0,
    'min' : 100.0,
    'max' : 800.0,
    'ativo' : true,
    'critico' : false,
    'estado' : 'OK',
  },
];

//Definir o enum de estados
enum Estado {inativo, ok, atencao, alerta, critico}

Estado estadoFromString(String s){
  switch(s){
    case 'INATIVO':
      return Estado.inativo;
    case 'ATENCAO':
      return Estado.atencao;
    case 'ALERTA':
      return Estado.alerta;
    case 'CRITICO':
      return Estado.critico;
    default: return Estado.ok;
  }
  
}

String estadoToString(Estado e){
  switch(e){
    case Estado.inativo:
      return 'INATIVO';
    case Estado.atencao:
      return 'ATENCAO';
    case Estado.alerta:
      return 'ALERTA';
    case Estado.critico:
      return 'CRITICO';
    default: return 'CRITICO';
  }
}

String nivel(Map<String, dynamic> sensor){
  final valor = asDouble(sensor, 'valor');
  final min = asDouble(sensor, 'min');
  final max = asDouble(sensor, 'max');

  final banda = max - min;
  final margin = banda * 0.10;
  final histerese = banda * 0.02;

  final atual = estadoFromString(sensor['estado'] as String);

  if (valor < min || valor > max) return 'ALERTA';
  if (valor < min  - margin || valor > max + margin) return 'CRÍTICO';

  if(atual == Estado.alerta || atual == Estado.critico || atual == Estado.atencao){
    final okComHisterese =
    (valor >= min + histerese && valor <= max - histerese);
    return okComHisterese ? 'OK' : 'ATENCAO'; 
  }
  return 'OK';
}

//FSM Decidir o próximo estado do sensor a partir do 
//estado atual + o nível + ativo

Estado proximoEstado(Estado atual, String nv, {required bool ativo}){
  if(!ativo) return Estado.inativo;

  switch(atual){
    
    case Estado.inativo:
      return ativo ? Estado.ok : Estado.inativo;
    case Estado.ok:
      if(nv == 'OK') return Estado.ok;
      if(nv == 'ATENCAO') return Estado.atencao;
      if(nv == 'ALERTA') return Estado.alerta;
      return Estado.critico;
      
    case Estado.atencao:
      if(nv == 'OK') return Estado.ok;
      if(nv == 'ATENCAO') return Estado.atencao;
      if(nv == 'ALERTA') return Estado.alerta;
      return Estado.critico;

    case Estado.alerta:
      if(nv == 'OK') return Estado.ok;
      if(nv == 'ATENCAO') return Estado.atencao;
      if(nv == 'ALERTA') return Estado.alerta;
      return Estado.critico;

    case Estado.critico:
      if(nv == 'CRITICO') return Estado.critico;
      if(nv == 'ATENCAO') return Estado.atencao;
      if(nv == 'ALERTA') return Estado.alerta;
      return Estado.ok;
  }
}
void atualizarLeitura() {
  for (final sensor in sensores) {
    if (!sensor['ativo']) continue;

    final min = asDouble(sensor, 'min');
    final max = asDouble(sensor, 'max');
    final valor = asDouble(sensor, 'valor');

    final centro = (min + max) / 2;

    final direcao = (centro - valor) * 0.05;
    final ruido = (aleatorio.nextDouble() - 0.5) * (max - min) * 0.03;
    var novo = valor + direcao + ruido;

    if (aleatorio.nextDouble() < 0.04) {
      novo += (aleatorio.nextDouble() - 0.5) * (max - min) * 0.25;
    }

    sensor['valor'] = novo;
  }
}

void aplicarFSM() {
  for (final sensor in sensores) {
    final ativo = sensor['ativo'];
    final atual = estadoFromString(sensor['estado'] as String);
    final nv = nivel(sensor);
    final prox = proximoEstado(atual, nv, ativo: ativo);

    sensor['estado'] = estadoToString(prox);

    if (prox == Estado.critico && sensor['critico'] && ativo) {
      print("!! ${sensor['nome']}: CRITICO - notificar EQUIPE");
    }

    final valor = asDouble(sensor, 'valor');
    final min = asDouble(sensor, 'min');
    final max = asDouble(sensor, 'max');

    final estouroGrave =
        (valor < min - (max - min) * 0.30) ||
        (valor > max + (max - min) * 0.30);
    if (estouroGrave) {
      sensor['ativo'] = false;
      sensor['estado'] = 'INATIVO';
      print("!! ${sensor['nome']} DESLIGADO por segurança");
    }
  }
  
}
void supervisorSistema() {
  final criticosAtivos = sensores
      .where(
        (sensor) =>
            sensor['ativo'] &&
            sensor['estado'] == 'CRITICO' &&
            sensor['critico'],
      )
      .length;

  if (criticosAtivos >= 2) {
    print(">>> SUPERVISOR: Dois ou mais sensores CRITICOS de alto risco <<<");
  }
}
void main(){}
