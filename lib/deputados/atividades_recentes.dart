import 'package:consuming_api_deputies/deputados/depu_api.dart';
import 'package:flutter/material.dart';

class AtividadesScreen extends StatefulWidget {
  final String deputadoId;

  const AtividadesScreen({Key? key, required this.deputadoId})
      : super(key: key);

  @override
  _AtividadesScreenState createState() => _AtividadesScreenState();
}

class _AtividadesScreenState extends State<AtividadesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 147, 81),
        title: const Text(
          'Atividades do Deputado',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchAtividades(widget.deputadoId, '', ''),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
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
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('id: ${snapshot.data?[index]['id'].toString()}'),
                        Text(
                            'DataHoraInicio: ${snapshot.data?[index]['dataHoraInicio']}'),
                        Text(
                            'DataHoraFim: ${snapshot.data?[index]['dataHoraFim']}'),
                        Text('Situação: ${snapshot.data?[index]['situacao']}'),
                        Text(
                            'Descrição Tipo: ${snapshot.data?[index]['descricaoTipo']}'),
                        Text(
                            'Descrição: ${snapshot.data?[index]['descricao']}'),
                        Text('Uri: ${snapshot.data?[index]['uri']}'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
