import 'package:flutter/material.dart';
import 'package:home_pause/views/components/bottom_nav_bar.dart';
import 'package:home_pause/views/principal/beneficios.view.dart';

class PrincipalView extends StatelessWidget {
  const PrincipalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Olá, Fulano",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9399F9),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Vamos se exercitar?",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/mulher_escritorio.png',
                width: 350,
              ),
            ),
            const SizedBox(height: 40),
            _buildCard(
              title: "Exercícios de ginástica laboral",
              description: "Vamos iniciar seus exercícios diários?",
              color: const Color(0xFF9399F9),
              textColor: Colors.white,
              iconColor: Colors.white,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildCard(
              title: "Benefícios de praticar ginástica laboral",
              description:
                  "Você sabia que praticar ginástica laboral todos os dias traz muitos benefícios para sua mente e corpo?",
              color: const Color(0xFFF5F5F5),
              textColor: Colors.black,
              iconColor: const Color(0xFF9399F9),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BeneficiosView()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Lógica de navegação baseada no índice
        },
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String description,
    required Color color,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 14, color: textColor.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Icon(
              Icons.arrow_circle_right,
              color: iconColor,
              size: 60,
            ),
          ],
        ),
      ),
    );
  }
}
