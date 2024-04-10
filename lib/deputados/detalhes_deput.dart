import 'package:consuming_api_deputies/deputados/atividades_recentes.dart';

import 'package:consuming_api_deputies/deputados/despesas.dart';

import 'package:flutter/material.dart';

class DeputadoDetalhesScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final deputado;

  const DeputadoDetalhesScreen({Key? key, required this.deputado})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deputado.nome),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black),
                  left: BorderSide(width: 1.0, color: Colors.black),
                  right: BorderSide(width: 1.0, color: Colors.black),
                  bottom: BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  'https://www.camara.leg.br/internet/deputado/bandep/${deputado.id}.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome: ${deputado.nome}',
                      style: const TextStyle(fontSize: 20)),
                  Text('Partido: ${deputado.siglaPartido}'),
                  Text('Estado: ${deputado.siglaUf}'),
                  Text('Email: ${deputado.email}'),
                  Text('Url Partido: ${deputado.uriPartido}'),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(100, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 113, 113, 114)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GastosDetalhesScreen(
                          deputadoId: deputado.id.toString(),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '    Gastos    ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(100, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 113, 113, 114)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AtividadesScreen(
                          deputadoId: deputado.id.toString(),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Atividades',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
