import 'dart:convert';
import 'package:http/http.dart' as http;

class Comissao {
  final int id;
  final String uri;
  final String titulo;
  final int legislatura;

  final Map<String, dynamic> detalhes;
  final List<dynamic> deputados;

  Comissao({
    required this.id,
    required this.uri,
    required this.titulo,
    required this.legislatura,
    this.detalhes = const {},
    this.deputados = const [],
  });

  factory Comissao.fromMap(Map<String, dynamic> map) {
    return Comissao(
      id: map['id'],
      uri: map['uri'],
      titulo: map['titulo'],
      legislatura: map['idLegislatura'],
    );
  }
}

class ComissaoDetalhe {
  final int id;
  final String uri;
  final String titulo;
  final int idLegislatura;
  final String telefone;
  final String email;
  final List<String>? keywords;
  final int? idSituacao;
  final String? situacao;
  final String? urlWebsite;
  final String? urlDocumento;
  final Coordenador coordenador;

  ComissaoDetalhe({
    required this.id,
    required this.uri,
    required this.titulo,
    required this.idLegislatura,
    required this.situacao,
    required this.telefone,
    required this.email,
    this.keywords,
    this.idSituacao,
    this.urlWebsite,
    this.urlDocumento,
    required this.coordenador,
  });

  factory ComissaoDetalhe.fromJson(Map<String, dynamic> json) {
    return ComissaoDetalhe(
      id: json['id'],
      uri: json['uri'],
      titulo: json['titulo'],
      idLegislatura: json['idLegislatura'],
      situacao: json['situacao'],
      telefone: json['telefone'],
      email: json['email'],
      keywords:
          json['keywords'] != null ? List<String>.from(json['keywords']) : null,
      idSituacao: json['idSituacao'],
      urlWebsite: json['urlWebsite'],
      urlDocumento: json['urlDocumento'],
      coordenador: Coordenador.fromJson(json['coordenador']),
    );
  }
}

class Coordenador {
  final int id;
  final String uri;
  final String nome;
  final String siglaPartido;
  final String uriPartido;
  final String siglaUf;
  final int idLegislatura;
  final String urlFoto;
  final String email;

  Coordenador({
    required this.id,
    required this.uri,
    required this.nome,
    required this.siglaPartido,
    required this.uriPartido,
    required this.siglaUf,
    required this.idLegislatura,
    required this.urlFoto,
    required this.email,
  });

  factory Coordenador.fromJson(Map<String, dynamic> json) {
    return Coordenador(
      id: json['id'],
      uri: json['uri'],
      nome: json['nome'],
      siglaPartido: json['siglaPartido'],
      uriPartido: json['uriPartido'],
      siglaUf: json['siglaUf'],
      idLegislatura: json['idLegislatura'],
      urlFoto: json['urlFoto'],
      email: json['email'],
    );
  }
}

class DeputadoComissao {
  final int id;
  final String urlFoto;
  final String nome;
  final String siglaPartido;
  final String siglaUf;
  final String email;
  final String titulo;
  final String uriPartido;

  DeputadoComissao({
    required this.id,
    required this.urlFoto,
    required this.nome,
    required this.siglaPartido,
    required this.siglaUf,
    required this.email,
    required this.titulo,
    required this.uriPartido,
  });

  factory DeputadoComissao.fromJson(Map<String, dynamic> json) {
    return DeputadoComissao(
      id: json['id'],
      urlFoto: json['urlFoto'] ?? '',
      nome: json['nome'] ?? '',
      siglaPartido: json['siglaPartido'] ?? '',
      siglaUf: json['siglaUf'] ?? '',
      email: json['email'] ?? '',
      titulo: json['titulo'] ?? '',
      uriPartido: json['uriPartido'] ?? '',
    );
  }
}

class ComissoesApi {
  static Future<List<Comissao>> getComissoes() async {
    final response = await http
        .get(Uri.parse('https://dadosabertos.camara.leg.br/api/v2/frentes'));

    if (response.statusCode == 200) {
      final List<dynamic> comissoesJson = jsonDecode(response.body)['dados'];
      return comissoesJson
          .map((dynamic comissaoJson) => Comissao.fromMap(comissaoJson))
          .toList();
    } else {
      throw Exception('Erro ao carregar as comissoes');
    }
  }
}

Future<List<DeputadoComissao>> getDeputadosComissao(int id) async {
  final response = await http.get(Uri.parse(
      'https://dadosabertos.camara.leg.br/api/v2/frentes/$id/membros'));

  if (response.statusCode == 200) {
    final List<dynamic> deputadosJson = jsonDecode(response.body)['dados'];
    print('Response Body: ${response.body}');
    return deputadosJson
        .map((json) => DeputadoComissao.fromJson(json))
        .toList();
  } else {
    throw Exception('Erro ao carregar os deputados da comissao');
  }
}
