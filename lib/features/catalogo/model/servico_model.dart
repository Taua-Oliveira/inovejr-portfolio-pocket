import 'package:flutter/foundation.dart';

/// Modelo imutável que representa um serviço oferecido no catálogo da Inove Jr.
@immutable
class ServicoModel {
  /// Cria uma instância imutável de [ServicoModel].
  const ServicoModel({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.descricaoCurta,
    required this.descricaoCompleta,
    required this.prazoMedio,
    required this.entregaveis,
    required this.iconeNome,
  });

  /// Identificador único do serviço no catálogo.
  final String id;

  /// Nome comercial do serviço exibido nos cartões e na tela de detalhes.
  final String titulo;

  /// Categoria usada para agrupamento e filtragem (ex: "Mobile", "Web", "Sistemas").
  final String categoria;

  /// Resumo breve apresentado na listagem do catálogo.
  final String descricaoCurta;

  /// Descrição detalhada com escopo, benefícios e contexto do serviço.
  final String descricaoCompleta;

  /// Estimativa média de duração do projeto (ex: "4 a 6 semanas").
  final String prazoMedio;

  /// Lista de artefatos e entregas previstas ao final do projeto.
  final List<String> entregaveis;

  /// Identificador textual simples para mapear o ícone correspondente na View.
  final String iconeNome;

  /// Retorna uma cópia de [ServicoModel] substituindo apenas os campos informados.
  ServicoModel copyWith({
    String? id,
    String? titulo,
    String? categoria,
    String? descricaoCurta,
    String? descricaoCompleta,
    String? prazoMedio,
    List<String>? entregaveis,
    String? iconeNome,
  }) {
    return ServicoModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      categoria: categoria ?? this.categoria,
      descricaoCurta: descricaoCurta ?? this.descricaoCurta,
      descricaoCompleta: descricaoCompleta ?? this.descricaoCompleta,
      prazoMedio: prazoMedio ?? this.prazoMedio,
      entregaveis: entregaveis ?? this.entregaveis,
      iconeNome: iconeNome ?? this.iconeNome,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServicoModel &&
        other.id == id &&
        other.titulo == titulo &&
        other.categoria == categoria &&
        other.descricaoCurta == descricaoCurta &&
        other.descricaoCompleta == descricaoCompleta &&
        other.prazoMedio == prazoMedio &&
        listEquals(other.entregaveis, entregaveis) &&
        other.iconeNome == iconeNome;
  }

  @override
  int get hashCode => Object.hash(
        id,
        titulo,
        categoria,
        descricaoCurta,
        descricaoCompleta,
        prazoMedio,
        Object.hashAll(entregaveis),
        iconeNome,
      );

  @override
  String toString() {
    return 'ServicoModel(id: $id, titulo: $titulo, categoria: $categoria, '
        'prazoMedio: $prazoMedio, iconeNome: $iconeNome)';
  }
}
