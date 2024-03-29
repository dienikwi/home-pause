import 'package:flutter/material.dart';
import 'package:home_pause/views/components/text_field.component.dart';
import 'package:home_pause/views/login/login.view.dart';

class CadastroView extends StatelessWidget {
  const CadastroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Faça seu cadastro",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 30),
              const CustomTextField(
                labelText: 'Nome',
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                labelText: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                labelText: 'Senha',
                prefixIcon: Icons.lock,
                isObscure: true,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                labelText: 'Confirmar senha',
                prefixIcon: Icons.lock,
                isObscure: true,
              ),
              const SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  // Realizar cadastro do usuário
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9399F9),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Cadastrar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Já possui cadastro?  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    },
                    child: const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF9399F9), fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
