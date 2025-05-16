import 'package:kondus/src/modules/welcome/model/welcome_slide.dart';

class WelcomeSlidesRepository {
  const WelcomeSlidesRepository();

  List<WelcomeSlide> getWelcomeSlides() {
    return [
      const WelcomeSlide(
        emoji: '🔍',
        title: 'Encontre o que precisa',
        subtitle: 'Produtos e serviços oferecidos por vizinhos, direto no app.',
      ),
      const WelcomeSlide(
        emoji: '🤝',
        title: 'Negocie com facilidade',
        subtitle: 'Combine retirada, entrega e horário direto com o vizinho.',
      ),
      const WelcomeSlide(
        emoji: '💡',
        title: 'Evite gastos desnecessários!',
        subtitle:
            'Alugue ou peça emprestado de quem mora perto.',
      ),
      const WelcomeSlide(
        emoji: '📍',
        title: 'Retire ou receba em casa',
        subtitle:
            'Combine com o vizinho a forma de entrega mais prática pra vocês dois.',
      ),
      const WelcomeSlide(
        emoji: '🍰',
        title: 'Bolos, docinhos e mais!',
        subtitle:
            'Encontre delícias caseiras no app e compre direto dos vizinhos.',
      ),
    ];
  }
}
