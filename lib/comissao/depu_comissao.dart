import 'package:flutter/material.dart';
import 'package:consuming_api_deputies/comissao/api_comissao.dart';

class DeputadosComissaoScreen extends StatefulWidget {
  final int comissaoId;

  DeputadosComissaoScreen({Key? key, required this.comissaoId})
      : super(key: key);

  @override
  _DeputadosComissaoScreenState createState() =>
      _DeputadosComissaoScreenState();
}

class _DeputadosComissaoScreenState extends State<DeputadosComissaoScreen> {
  late Future<List<DeputadoComissao>> _futureDeputados;

  @override
  void initState() {
    super.initState();
    _futureDeputados = getDeputadosComissao(widget.comissaoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 147, 81),
          title: const Text('Deputados da Comissão',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: FutureBuilder<List<DeputadoComissao>>(
          future: _futureDeputados,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("Erro ao carregar os deputados: ${snapshot.error}");
              return Center(child: Text("Erro ao carregar os deputados."));
            } else if (snapshot.hasData) {
              final deputados = snapshot.data!;
              return ListView.builder(
                itemCount: deputados.length,
                itemBuilder: (context, index) {
                  final deputado = deputados[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 171, 168, 168)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(deputado.urlFoto),
                            radius: 30,
                          ),
                          Text('id: ${deputado.id.toString()}'),
                          Text('nome: ${deputado.nome}'),
                          Text('siglaPartido: ${deputado.siglaPartido}'),
                          Text('siglaUf: ${deputado.siglaUf}'),
                          Text('Titulo: ${deputado.titulo}'),
                          Text('email: ${deputado.email}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: Text("Nenhum dado encontrado."));
          },
        ));
  }
}
