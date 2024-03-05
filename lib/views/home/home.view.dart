import 'package:flutter/material.dart';
import 'package:home_pause/views/login/login.view.dart';
import 'package:home_pause/views/cadastro/cadastro.view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle titulo = TextStyle(fontSize: 35);
    const TextStyle subtitulo = TextStyle(fontSize: 18, color: Colors.grey);
    const TextStyle descricao = TextStyle(fontSize: 13, color: Colors.grey);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bem-vindo",
                  style: titulo,
                ),
                Text(
                  "Vamos começar?",
                  style: subtitulo,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Image.asset(
              'assets/mulher_tela_inicial.png',
              width: 320,
            ),
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Escolha uma opção para iniciar',
                  style: descricao,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 45),
                    backgroundColor: const Color(0xFF9399F9),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CadastroView()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 45),
                  ),
                  child: const Text(
                    'Cadastro',
                    style: TextStyle(fontSize: 18),
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
