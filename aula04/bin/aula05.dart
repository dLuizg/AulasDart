void main(List<String> arguments) {
  double sensorTemp = 32.5;
  double sensorUmidade = 30;

  print("Sala Monitorada");
  print("==========================");
  print("=Monitoramento iniciado=");
  print("==========================");

  sensorTemp = 37.5;
  sensorUmidade = 20;

  if (sensorTemp >= 33.5 && sensorUmidade<27) {
    print("=      ALERTA      =\nTemperatura e/ou umidade alterada(s)\nTemperatura: ${sensorTemp}ºC\nUmidade: ${sensorUmidade}");
  }
}
