import 'dart:convert';
import 'package:consuming_api_deputies/comissao/api_comissao.dart';
import 'package:consuming_api_deputies/comissao/depu_comissao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComicoesDetalhesScreen extends StatefulWidget {
  final int comissaoId;

  const ComicoesDetalhesScreen({Key? key, required this.comissaoId})
      : super(key: key);

  @override
  _ComicoesDetalhesScreenState createState() => _ComicoesDetalhesScreenState();
}

class _ComicoesDetalhesScreenState extends State<ComicoesDetalhesScreen> {
  late Future<ComissaoDetalhe> _futureComissaoDetalhe;

  static Future<ComissaoDetalhe> getComissao(int id) async {
    final response = await http.get(
        Uri.parse('https://dadosabertos.camara.leg.br/api/v2/frentes/$id'));

    if (response.statusCode == 200) {
      return ComissaoDetalhe.fromJson(jsonDecode(response.body)['dados']);
    } else {
      throw Exception('Erro ao carregar a comissão');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureComissaoDetalhe = getComissao(widget.comissaoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 147, 81),
        title: const Text('Detalhes das Comissões',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: FutureBuilder<ComissaoDetalhe>(
        future: _futureComissaoDetalhe,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final comissao = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 171, 168, 168).withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.titulo,
                          style: const TextStyle(fontSize: 20)),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Cordeandor: ${snapshot.data!.coordenador.nome}'),
                          Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                              child: ClipRect(
                                child: Image.network(
                                  snapshot.data!.coordenador.urlFoto,
                                  width: 60,
                                  height: 60,
                                ),
                              )),
                        ],
                      ),
                      Text(
                          'Sigla Partido: ${snapshot.data!.coordenador.siglaPartido}'),
                      Text('Sigla UF: ${snapshot.data!.coordenador.siglaUf}'),
                      Text('Telefone: ${snapshot.data!.telefone}'),
                      Text('Email: ${comissao.email}'),
                      Text('Situacao: ${comissao.situacao}'),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeputadosComissaoScreen(
                                      comissaoId: comissao.id),
                                ),
                              );
                            },
                            child: const Text('Membros'),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("Erro ao carregar a comissão.");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
