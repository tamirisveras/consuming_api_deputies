import 'dart:convert';
import 'package:http/http.dart' as http;

class Deputado {
  final int id;
  final String urlFoto;
  final String nome;
  final String siglaPartido;
  final String siglaUf;
  final String email;
  final String uriPartido;

  Deputado({
    required this.id,
    required this.urlFoto,
    required this.nome,
    required this.siglaPartido,
    required this.siglaUf,
    required this.email,
    required this.uriPartido,
  });

  factory Deputado.fromJson(Map<String, dynamic> json) {
    return Deputado(
      id: json['id'],
      urlFoto: json['urlFoto'] ?? '',
      nome: json['nome'] ?? '',
      siglaPartido: json['siglaPartido'] ?? '',
      siglaUf: json['siglaUf'] ?? '',
      email: json['email'] ?? '',
      uriPartido: json['uriPartido'] ?? '',
    );
  }
}

class DeputadosApi {
  static Future<List<Deputado>> getDeputados() async {
    final response = await http
        .get(Uri.parse('https://dadosabertos.camara.leg.br/api/v2/deputados'));
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['dados'];
      return json.map((e) => Deputado.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load deputados');
    }
  }
}

// Api de Despesas do Deputado
Future<List<dynamic>> fetchDespesas(
    String deputadoId, String? ano, String? mes) async {
  // Ajuste a URL da API conforme necessário para incluir os parâmetros de ano e mês
  final response = await http.get(Uri.parse(
      'https://dadosabertos.camara.leg.br/api/v2/deputados/$deputadoId/despesas?ordem=ASC&ordenarPor=mes&ano=$ano&mes=$mes'));

  if (response.statusCode == 200) {
    return json.decode(response.body)['dados'];
  } else {
    throw Exception('Falha ao carregar despesas');
  }
}

// Api Atividades do Deputado

Future<List<dynamic>> fetchAtividades(
    String deputadoId, String? ano, String? mes) async {
  // Ajuste a URL da API conforme necessário para incluir os parâmetros de ano e mês
  final response = await http.get(Uri.parse(
      'https://dadosabertos.camara.leg.br/api/v2/deputados/$deputadoId/eventos?dataInicio=2024-01-01&dataFim=2024-04-06&ordem=ASC&ordenarPor=dataHoraInicio'));

  if (response.statusCode == 200) {
    return json.decode(response.body)['dados'];
  } else {
    throw Exception('Falha ao carregar Atividades');
  }
}
