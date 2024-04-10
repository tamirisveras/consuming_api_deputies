import 'package:consuming_api_deputies/comicao/detalhe_comissao.dart';
import 'package:flutter/material.dart';
import 'package:consuming_api_deputies/comicao/api_comissao.dart';

class ComissoesScreen extends StatefulWidget {
  const ComissoesScreen({Key? key}) : super(key: key);

  @override
  _ComissoesScreenState createState() => _ComissoesScreenState();
}

class _ComissoesScreenState extends State<ComissoesScreen> {
  late Future<List<Comissao>> _futureComissoes;

  @override
  void initState() {
    super.initState();
    _futureComissoes = ComissoesApi.getComissoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 147, 81),
        title: const Text('Comissões',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Comissao>>(
        future: _futureComissoes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final comissao = snapshot.data![index];
                return Container(
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
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                      title: Text(comissao.titulo),
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComicoesDetalhesScreen(
                                comissaoId: comissao.id,
                              ),
                            ),
                          )),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("Erro ao carregar as comissões.");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
