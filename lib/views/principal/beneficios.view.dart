import 'package:flutter/material.dart';
import 'package:home_pause/views/components/bottom_nav_bar.dart';

class BeneficiosView extends StatelessWidget {
  const BeneficiosView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> beneficios = [
      {
        'id_beneficio': '1',
        'titulo': 'Melhora a postura',
        'ds_beneficio':
            'A prática regular ajuda a corrigir e manter uma postura adequada. Funcionários ativos tendem a ter maior rendimento e disposição no trabalho.'
      },
      {
        'id_beneficio': '2',
        'titulo': 'Elimina a tensão no ambiente de trabalho',
        'ds_beneficio':
            'Além dos exercícios, a ginástica laboral também conta com dinâmicas e jogos cooperativos. Eles contribuem para a criação de um ambiente de trabalho mais descontraído.'
      },
      {
        'id_beneficio': '3',
        'titulo': 'Reduz os acidentes de trabalho',
        'ds_beneficio':
            'Segundo dados do INSS (Instituto Nacional do Seguro Social) e do SmartLab, o Brasil registra mais de 612 mil casos de acidentes de trabalho por ano. A ginástica laboral é uma das principais aliadas das empresas para diminuir os acidentes no dia a dia de trabalho. As técnicas de alongamento, respiração e reeducação postural dos exercícios laborais também contribuem para o aumento do foco e atenção durante o trabalho. Assim o colaborador tem maior consciência dos seus limites e do momento certo para parar e recuperar as energias.'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Center(
              child: Image.asset(
                'assets/exercicio_pessoa.png',
                width: 350,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Benefícios',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: beneficios.map((beneficio) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          beneficio['titulo']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          beneficio['ds_beneficio']!,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
