import 'package:flutter/material.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/data/models/beneficio_model.dart';
import 'package:home_pause/data/services/beneficio_service.dart';
import 'package:home_pause/views/components/bottom_nav_bar.dart';

class BeneficiosView extends StatefulWidget {
  const BeneficiosView({super.key});

  @override
  State<BeneficiosView> createState() => _BeneficiosViewState();
}

class _BeneficiosViewState extends State<BeneficiosView> {
  final BeneficioService _beneficioService = BeneficioService();
  List<BeneficioModel> _beneficios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBeneficios();
  }

  Future<void> _loadBeneficios() async {
    try {
      final beneficios = await _beneficioService.getAllBeneficios();
      if (mounted) {
        setState(() {
          _beneficios = beneficios;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erro ao carregar benefícios: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _loadBeneficios,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
              _buildBeneficiosContent(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) => _handleBottomNavTap(context, index),
      ),
    );
  }

  Widget _buildBeneficiosContent() {
    if (_beneficios.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(
                Icons.info_outline,
                size: 48,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'Nenhum benefício encontrado',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Puxe para baixo para atualizar',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: _beneficios.map((beneficio) {
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
                  beneficio.titulo,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  beneficio.dsBeneficio,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _handleBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.main);
        break;
      case 1:
        // TODO: Implementar navegação para tela de histórico
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Funcionalidade de histórico em desenvolvimento'),
          ),
        );
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.profile);
        break;
    }
  }
}
