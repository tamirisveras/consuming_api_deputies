import 'package:consuming_api_deputies/deputados/depu_api.dart';
import 'package:flutter/material.dart';

class GastosDetalhesScreen extends StatefulWidget {
  final String deputadoId;

  const GastosDetalhesScreen({Key? key, required this.deputadoId})
      : super(key: key);

  @override
  _GastosDetalhesScreenState createState() => _GastosDetalhesScreenState();
}

class _GastosDetalhesScreenState extends State<GastosDetalhesScreen> {
  String? selectedAno;
  String? selectedMes;

  @override
  void initState() {
    super.initState();
    // Obtendo o ano e mês atuais
    final currentDate = DateTime.now();
    selectedAno = currentDate.year.toString();
    selectedMes = currentDate.month.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 147, 81),
        title: const Text(
          'Gastos do Deputado',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: [
          DropdownButton<String>(
            value: selectedAno,
            items: <String>['2024', '2023', '2022']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedAno = value;
              });
            },
          ),
          DropdownButton<String>(
            value: selectedMes,
            items: <String>[
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
              '7',
              '8',
              '9',
              '10',
              '11',
              '12'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedMes = value;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchDespesas(widget.deputadoId, selectedAno, selectedMes),
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ano: ${snapshot.data?[index]['ano'].toString()}'),
                        Text('Mês: ${snapshot.data?[index]['mes'].toString()}'),
                        Text(
                            'Tipo de despesa: ${snapshot.data?[index]['tipoDespesa']}'),
                        Text(
                            'dataDocumento: ${snapshot.data?[index]['dataDocumento']}'),
                        Text(
                            'Valor: ${snapshot.data?[index]['valorDocumento']}'),
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
