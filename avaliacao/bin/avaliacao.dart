/*
Código feito e elaborado pela participação de: 
Luiz Gustavo P. Diniz RA:25001239 e 
Henrique de O. Molinari RA:25001176
*/
void main() {

  //Representamos cada produto como um map (um map list)
  List<Map<String, dynamic>> carrinho = [
    {'nome': 'Arroz', 'preco': 25.0, 'qtd': 2},
    {'nome': 'Feijão', 'preco': 30.0, 'qtd': 1},
    {'nome': 'Café', 'preco': 40.0, 'qtd': 1},
  ];

  // Pega o produto e multiplica pela quantidade para pegar seu subtotal
  double subtotal(Map<String, dynamic> produto) {
    return produto['preco'] * produto['qtd'];
  }

  // Soma todos os subtotais e dá os devidos descontos ou soma do frete
  double calcularTotal(List<Map<String, dynamic>> carrinho) {
  double total = 0;

  for (var produto in carrinho) {
      total += subtotal(produto);
  }

  //SE for maior que 100, desconta 10%
  if (total > 100) {
      total = total * 0.9; 
  
  //Mas SE for menor que 50, estabelece 10 reais fixos como frete
  }else if (total < 50) {
      total += 10; 
  }

    return total;
  }

  // Imprime cada produto usando o laço adequado para a situação que parte do Map
  for (var produto in carrinho) {
    print(
        "Produto: ${produto['nome']} | Quantidade: ${produto['qtd']} | Subtotal: ${subtotal(produto)}");
  }
  //imprime o valor final total da compra.

  print("\nTotal final: ${calcularTotal(carrinho)}");
}
