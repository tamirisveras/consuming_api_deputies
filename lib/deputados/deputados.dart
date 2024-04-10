import 'package:consuming_api_deputies/deputados/depu_api.dart';
import 'package:consuming_api_deputies/deputados/detalhes_deput.dart';
import 'package:flutter/material.dart';

class DeputadosScreen extends StatefulWidget {
  const DeputadosScreen({
    Key? key,
  }) : super(key: key);
  @override
  _DeputadosScreenState createState() => _DeputadosScreenState();
}

class _DeputadosScreenState extends State<DeputadosScreen> {
  late Future<List<Deputado>> _futureDeputados;
  String _buscaCriterio = 'nome';
  String _buscaValor = '';

  @override
  void initState() {
    super.initState();
    _futureDeputados = DeputadosApi.getDeputados();
  }

  void _atualizarDeputados() {
    setState(() {
      _futureDeputados = DeputadosApi.getDeputados().then((deputados) {
        return deputados.where((deputado) {
          bool match;
          switch (_buscaCriterio) {
            case 'nome':
              match = deputado.nome
                  .toLowerCase()
                  .contains(_buscaValor.toLowerCase());
              break;
            case 'partido':
              match = deputado.siglaPartido
                  .toLowerCase()
                  .contains(_buscaValor.toLowerCase());
              break;
            case 'estado':
              match = deputado.siglaUf
                  .toLowerCase()
                  .contains(_buscaValor.toLowerCase());
              break;
            default:
              match = false;
          }
          return match;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        backgroundColor: const Color.fromARGB(255, 11, 147, 81),
        toolbarHeight: 80,
        title: Row(children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  hintText: 'Buscar deputado(a)',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                ),
                onChanged: (value) {
                  _buscaValor = value;
                  _atualizarDeputados();
                },
              ),
            ),
          ),
          DropdownButton<String>(
            style: TextStyle(color: Colors.white),
            dropdownColor: const Color.fromARGB(255, 11, 147, 81),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            value: _buscaCriterio,
            onChanged: (String? newValue) {
              setState(() {
                _buscaCriterio = newValue!;
                _atualizarDeputados();
              });
            },
            items: <String>['nome', 'partido', 'estado']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ]),
      ),
      body: FutureBuilder<List<Deputado>>(
        future: _futureDeputados,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return // Dentro do método build da _DeputadosScreenState
                ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
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
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(snapshot.data![index].urlFoto),
                        title: Text(snapshot.data![index].nome),
                        subtitle: Text(
                            'Partido: ${snapshot.data![index].siglaPartido}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeputadoDetalhesScreen(
                                  deputado: snapshot.data![index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("Erro ao carregar os dados dos deputados.");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
