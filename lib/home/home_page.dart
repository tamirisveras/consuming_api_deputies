import 'package:consuming_api_deputies/comicao/comissoes.dart';
import 'package:consuming_api_deputies/deputados/deputados.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 147, 81),
        title: const Text('Câmara dos Deputados',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 248, 246, 246),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/img/camara.png',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text('Escolha uma das opções abaixo ')),
                SizedBox(height: 16),
                Icon(Icons.arrow_downward),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 180,
                child: Card(
                  child: ListTile(
                    title: Image.asset(
                      'assets/img/deputados.jpg',
                    ),
                    subtitle: const Text('Lista de deputados',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeputadosScreen()),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                child: Card(
                  child: ListTile(
                    title: Image.asset(
                      'assets/img/comissao.png',
                      height: 90,
                      width: 50,
                    ),
                    subtitle: const Text(
                      'Lista de comissões',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ComissoesScreen()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
