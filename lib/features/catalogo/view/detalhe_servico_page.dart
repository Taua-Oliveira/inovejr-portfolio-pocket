import 'package:flutter/material.dart';
import 'package:inovejr_portfolio_pocket/features/catalogo/model/servico_model.dart';

// TODO: Tela a ser implementada pela equipe de UI
// Dica de integração com orçamento via WhatsApp:
// Utilize `CatalogoViewModel.gerarMensagemOrcamento(...)` e o pacote `url_launcher`
// para montar o link `https://wa.me/...` com o texto já formatado.

/// Tela de detalhamento de um serviço selecionado no catálogo.
class DetalheServicoPage extends StatelessWidget {
  /// Cria a tela de detalhes recebendo o [servico] selecionado.
  const DetalheServicoPage({
    super.key,
    required this.servico,
  });

  /// Serviço exibido nesta tela de detalhes.
  final ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(servico.titulo),
      ),
      body: const Center(
        child: Text('Detalhes do Serviço (em desenvolvimento)'),
      ),
    );
  }
}
