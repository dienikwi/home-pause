# Copilot Instructions for `home_pause`

## Visão Geral

- App Flutter para Android, projeto de TCC.
- Sem backend por enquanto, mas haverá integração futura com Firebase.
- Arquitetura limpa com separação clara de responsabilidades.
- Navegação via sistema de rotas centralizado em `lib/core/routes/`.

## Estrutura do Projeto

```
lib/
├── core/
│   ├── constants/     # Constantes centralizadas (cores, strings, dimensões, etc.)
│   ├── routes/        # Sistema de rotas e navegação
│   └── utils/         # Utilitários gerais
├── shared/
│   └── widgets/       # Componentes reutilizáveis globais
├── themes/            # Configuração de temas
├── views/             # Telas organizadas por feature
│   ├── <feature>/
│   │   ├── components/   # Componentes específicos da feature
│   │   └── <screen>_view.dart
└── main.dart
```

## Convenções e Boas Práticas

### Organização de Código

- **Constantes**: Centralize TODAS as constantes em `lib/core/constants/`:
  - `app_colors.dart` - Cores do app
  - `app_strings.dart` - Textos e labels
  - `app_dimensions.dart` - Espaçamentos e tamanhos
  - `app_text_styles.dart` - Estilos de texto
  - `app_assets.dart` - Caminhos de assets

### Widgets e Componentes

- **Componentes globais**: Crie em `lib/shared/widgets/` para uso em múltiplas features
- **Componentes específicos**: Crie em `lib/views/<feature>/components/` para uso local
- **Reutilização**: Sempre extraia widgets repetidos em componentes reutilizáveis
- **Naming**: Use prefixo `Custom` para widgets personalizados (ex: `CustomButton`, `CustomCard`)

### Navegação e Rotas

- **Sistema centralizado**: Use `AppRouter` em `lib/core/routes/app_router.dart`
- **Constantes de rotas**: Defina em `lib/core/routes/app_routes.dart`
- **Navegação**: Use `AppRouter.navigateTo()` ao invés de `Navigator.push()` direto

### Temas e Estilo

- **Tema único**: Configure em `lib/themes/light_theme.dart`
- **Google Fonts**: Use fonte padrão Roboto via `google_fonts`
- **Cores consistentes**: Sempre referencie `AppColors` para cores
- **Espaçamentos**: Use `AppDimensions` para padding, margin, etc.

### Assets e Recursos

- **Organização**: Coloque em `assets/` e registre no `pubspec.yaml`
- **Referências**: Use `AppAssets` para caminhos de imagens
- **Otimização**: Prefira formatos eficientes (PNG para ícones, WEBP para fotos)

## Padrões de Código

### Estrutura de Telas (Views)

```dart
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.homeTitle,
          style: AppTextStyles.titleLarge,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          children: [
            // Conteúdo da tela
          ],
        ),
      ),
    );
  }
}
```

### Componentes Reutilizáveis

```dart
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.buttonText.copyWith(
          color: textColor ?? AppColors.onPrimary,
        ),
      ),
    );
  }
}
```

### Navegação

```dart
// Definição de rotas
class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
}

// Uso da navegação
AppRouter.navigateTo(context, AppRoutes.login);
```

## Fluxos de Trabalho

- **Build**: `flutter build apk`
- **Rodar**: `flutter run`
- **Dependências**: `flutter pub get`
- **Limpeza**: `flutter clean` (quando houver problemas de build)

## Desenvolvimento de Features

### Nova Tela

1. Crie em `lib/views/<feature>/<screen>_view.dart`
2. Adicione a rota em `AppRoutes`
3. Configure no `AppRouter`
4. Use componentes de `shared/widgets/` quando possível

### Novo Componente

1. **Global**: `lib/shared/widgets/custom_<nome>.dart`
2. **Específico**: `lib/views/<feature>/components/<nome>.dart`
3. Sempre documente parâmetros obrigatórios e opcionais
4. Use `const` constructor quando possível

### Adição de Assets

1. Adicione arquivo em `assets/`
2. Registre no `pubspec.yaml`
3. Adicione referência em `AppAssets`
4. Use via `AppAssets.nomeDoAsset`

## Integração Futura

- **Firebase**: Centralize em `lib/services/`
- **APIs**: Crie em `lib/data/repositories/`
- **Models**: Organize em `lib/data/models/`
- **Estado**: Considere Provider ou BLoC em `lib/state/`

## Referências Importantes

- **Entrada**: `lib/main.dart`
- **Rotas**: `lib/core/routes/`
- **Constantes**: `lib/core/constants/`
- **Widgets**: `lib/shared/widgets/`
- **Telas**: `lib/views/`
- **Temas**: `lib/themes/`
- **Assets**: `assets/`

---

**Lembre-se**: Sempre priorize reutilização, legibilidade e manutenibilidade. Use as constantes centralizadas e siga os padrões estabelecidos para manter a consistência do projeto.

Para mais informações, consulte a [documentação oficial do Flutter](https://docs.flutter.dev/).
