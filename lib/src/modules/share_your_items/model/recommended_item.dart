import 'package:kondus/core/services/items/models/items_filter_model.dart';

class RecommendedItem {
  final String name;
  final ItemType type;
  final String description;
  final List<int> categoriesIds;
  final String actionType;

  RecommendedItem({
    required this.name,
    required this.type,
    required this.description,
    required this.categoriesIds,
    required this.actionType,
  });

  static final items = [
    RecommendedItem(
      name: "Reparo de ar condicionado",
      type: ItemType.servico,
      description:
          "Serviço de manutenção, limpeza e conserto de ar-condicionado. Atendo modelos do tipo [split/janela/inverter]. Com garantia e agendamento flexível.",
      categoriesIds: [5],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Aspirador",
      type: ItemType.produto,
      description:
          "Aspirador portátil ideal para limpeza doméstica ou automotiva. Equipamento em boas condições. Fácil de usar e com bom desempenho.",
      categoriesIds: [12],
      actionType: 'Aluguel',
    ),
    RecommendedItem(
      name: "Chave de Fenda",
      type: ItemType.produto,
      description:
          "Kit básico de chave de fenda para pequenos reparos. Ferramenta em boas condições. Ideal para uso esporádico.",
      categoriesIds: [9],
      actionType: 'Aluguel',
    ),
    RecommendedItem(
      name: "Personal Trainer",
      type: ItemType.servico,
      description:
          "Acompanhamento personalizado para treinos com foco em [condicionamento, emagrecimento ou hipertrofia]. Atendimento em casa ou online.",
      categoriesIds: [6],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Aula Particular",
      type: ItemType.servico,
      description:
          "Aulas em domicílio ou online nas áreas de [matemática, inglês, reforço escolar, etc.]. Flexível e focado em resultados.",
      categoriesIds: [14],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Cortador de Grama",
      type: ItemType.produto,
      description:
          "Cortador de grama em boas condições. Perfeito para manter jardins e quintais bem cuidados sem precisar comprar um equipamento próprio.",
      categoriesIds: [9],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Escada",
      type: ItemType.produto,
      description:
          "Escada dobrável multiuso ideal para pequenos reparos ou manutenção doméstica. Está em boas condições. Leve, segura e fácil de transportar.",
      categoriesIds: [9],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Furadeira",
      type: ItemType.produto,
      description:
          "Furadeira elétrica portátil com brocas inclusas. Ótima para instalações simples e reparos. Está em boas condições.",
      categoriesIds: [9],
      actionType: "Aluguel",
    ),
    //
    RecommendedItem(
      name: "Cuidador de Pets",
      type: ItemType.servico,
      description:
          "Serviço de cuidado e passeios com cães e gatos. Atendimento dentro do condomínio ou nas redondezas.",
      categoriesIds: [10, 15],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Serviço de Costura",
      type: ItemType.servico,
      description:
          "Pequenos reparos e ajustes em roupas, como bainhas, botões ou costuras simples. Atendimento no próprio condomínio.",
      categoriesIds: [5, 11],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Cadeira de Praia",
      type: ItemType.produto,
      description:
          "Cadeira leve e dobrável, ideal para usar na área comum, varandas ou momentos de lazer ao ar livre.",
      categoriesIds: [2, 13],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Faxina",
      type: ItemType.servico,
      description:
          "Limpeza detalhada de apartamentos e casas. Inclui cozinha, banheiros e áreas comuns.",
      categoriesIds: [12],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Serviço de Massagem",
      type: ItemType.servico,
      description:
          "Massoterapeuta com atendimento em domicílio. Alívio de estresse, dores musculares e relaxamento geral.",
      categoriesIds: [
        17,
        20,
      ],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Bolo de Pote",
      type: ItemType.produto,
      description:
          "Deliciosos bolos de pote com diversos sabores, feitos sob encomenda. Opção prática e saborosa.",
      categoriesIds: [4],
      actionType: "Venda",
    ),
    RecommendedItem(
      name: "Bomba de Encher",
      type: ItemType.produto,
      description:
          "Bomba elétrica usada para inflar piscinas, colchões ou brinquedos de verão. Funciona rápido e é fácil de usar.",
      categoriesIds: [3, 7],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Colchão Inflável",
      type: ItemType.produto,
      description:
          "Colchão inflável de casal, ótimo para visitas de última hora. Fácil de guardar e inflar.",
      categoriesIds: [2],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Aulas de Idioma",
      type: ItemType.servico,
      description:
          "Conversação em inglês, francês e alemão com foco em fluência e vocabulário do dia a dia. Ideal para iniciantes e intermediários.",
      categoriesIds: [14],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Caixa de Som",
      type: ItemType.produto,
      description:
          "Caixa de som portátil ideal para festas pequenas ou encontros entre vizinhos.",
      categoriesIds: [6],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Medidor de Pressão",
      type: ItemType.produto,
      description:
          "Equipamento confiável para aferir a pressão arterial de forma prática.",
      categoriesIds: [20],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Consulta de Acupuntura",
      type: ItemType.servico,
      description:
          "Sessões de acupuntura para alívio de dores e estresse. Atendimento domiciliar.",
      categoriesIds: [20],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Corte de Cabelo",
      type: ItemType.servico,
      description:
          "Corte prático em domicílio com atenção a estilo e conforto.",
      categoriesIds: [17],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Transporte de Encomendas",
      type: ItemType.servico,
      description:
          "Levo pequenas entregas entre blocos ou torres do condomínio.",
      categoriesIds: [16],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Aulas de Redação",
      type: ItemType.servico,
      description:
          "Correção e acompanhamento de textos para estudantes e vestibulandos.",
      categoriesIds: [14],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Aulas de Violão",
      type: ItemType.servico,
      description:
          "Aulas práticas e introdutórias para quem quer aprender a tocar violão.",
      categoriesIds: [14],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Extensão Elétrica",
      type: ItemType.produto,
      description:
          "Prolongador com vários metros de alcance. Útil em manutenções ou festas.",
      categoriesIds: [3],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Detector de Tensão",
      type: ItemType.produto,
      description:
          "Equipamento de segurança para identificar corrente em instalações.",
      categoriesIds: [3],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Bola de Pilates",
      type: ItemType.produto,
      description:
          "Equipamento versátil para exercícios físicos e alongamentos.",
      categoriesIds: [20],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Manicure e Pedicure",
      type: ItemType.servico,
      description:
          "Atendimento em domicílio para cuidados com unhas e cutículas.",
      categoriesIds: [17],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Carona Solidária",
      type: ItemType.servico,
      description:
          "Ajudo vizinhos com transporte esporádico em horários compatíveis.",
      categoriesIds: [16],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Lavagem de Tapetes",
      type: ItemType.servico,
      description:
          "Serviço de limpeza profunda de tapetes e carpetes em domicílio.",
      categoriesIds: [12],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Aulas de Redação",
      type: ItemType.servico,
      description:
          "Correção e acompanhamento de textos para estudantes e vestibulandos.",
      categoriesIds: [14],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Aulas de Piano",
      type: ItemType.servico,
      description:
          "Aulas particulares de piano para iniciantes e intermediários.",
      categoriesIds: [14],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Aulas de Guitarra",
      type: ItemType.servico,
      description: "Ensino prático e teórico de guitarra elétrica e acústica.",
      categoriesIds: [14],
      actionType: "Serviço",
    ),
    RecommendedItem(
      name: "Martelo",
      type: ItemType.produto,
      description:
          "Ferramenta básica para pequenas reformas e pendurar quadros.",
      categoriesIds: [3],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Prego",
      type: ItemType.produto,
      description: "Pregos de tamanhos variados para uso doméstico.",
      categoriesIds: [3],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Parafuso",
      type: ItemType.produto,
      description: "Parafusos diversos para consertos e instalações.",
      categoriesIds: [3],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Bola",
      type: ItemType.produto,
      description:
          "Bola de futebol disponível para empréstimo ou uso em grupo.",
      categoriesIds: [5],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Bijuteria",
      type: ItemType.produto,
      description:
          "Bijuterias artesanais feitas à mão, ideais para presentear.",
      categoriesIds: [8],
      actionType: "Venda",
    ),
    RecommendedItem(
      name: "Mangueira",
      type: ItemType.produto,
      description: "Mangueira para regar plantas ou lavar áreas externas.",
      categoriesIds: [2],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Pá",
      type: ItemType.produto,
      description: "Pá de jardinagem disponível para uso compartilhado.",
      categoriesIds: [2],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Jogo de Tabuleiro",
      type: ItemType.produto,
      description:
          "Jogo de tabuleiro divertido para compartilhar com os vizinhos.",
      categoriesIds: [5],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "DVDs ou Filmes",
      type: ItemType.produto,
      description: "Coleção de filmes clássicos para curtir em família.",
      categoriesIds: [5],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Raquete",
      type: ItemType.produto,
      description: "Ideal para partidas nas quadras do condomínio.",
      categoriesIds: [5],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Skate",
      type: ItemType.produto,
      description: "Para aproveitar as áreas abertas e calçadas do condomínio.",
      categoriesIds: [5],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Patins",
      type: ItemType.produto,
      description: "Diversão para adultos e crianças nas áreas comuns.",
      categoriesIds: [5],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Rede de Descanso",
      type: ItemType.produto,
      description: "Ideal para relaxar na varanda ou áreas de lazer.",
      categoriesIds: [5],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Brinquedos de Praia",
      type: ItemType.produto,
      description: "Baldinhos e pazinhas para brincar na areia do playground.",
      categoriesIds: [6],
      actionType: "Aluguel",
    ),
    RecommendedItem(
      name: "Baralho",
      type: ItemType.produto,
      description: "Perfeito para partidas com os vizinhos no salão de jogos.",
      categoriesIds: [5],
      actionType: "Empréstimo",
    ),
  ];
}
