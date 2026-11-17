import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Tela1(),
  ));
}

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  final _nomeController = TextEditingController();
  final _tripulantesController = TextEditingController();
  final _distanciaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 1: Configuração')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Comandante'),
            ),
            TextField(
              controller: _tripulantesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantidade de Tripulantes'),
            ),
            TextField(
              controller: _distanciaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Distância (Anos-Luz)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validações simples
                String nome = _nomeController.text;
                int? tripulantes = int.tryParse(_tripulantesController.text);
                double? distancia = double.tryParse(_distanciaController.text);

                if (nome.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O nome não pode estar vazio.')),
                  );
                  return;
                }
                if (tripulantes == null || tripulantes <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tripulantes devem ser maiores que zero.')),
                  );
                  return;
                }
                if (distancia == null || distancia <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Distância deve ser maior que zero.')),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tela2(
                      nome: nome,
                      tripulantes: tripulantes,
                      distancia: distancia,
                    ),
                  ),
                );
              },
              child: const Text('Avançar para Recursos'),
            ),
          ],
        ),
      ),
    );
  }
}

class Tela2 extends StatefulWidget {
  final String nome;
  final int tripulantes;
  final double distancia;

  const Tela2({
    super.key,
    required this.nome,
    required this.tripulantes,
    required this.distancia,
  });

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  final _diasController = TextEditingController();
  final _custoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 2: Recursos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _diasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Dias estimados'),
            ),
            TextField(
              controller: _custoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Custo por kg de combustível '),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int? dias = int.tryParse(_diasController.text);
                double? custoKg = double.tryParse(_custoController.text);

                if (dias == null || dias <= 0 || custoKg == null || custoKg <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insira valores maiores que zero.')),
                  );
                  return;
                }

                
                double combustivelTotal = (widget.distancia * widget.tripulantes) * 1000;
                double custoCombustivel = combustivelTotal * custoKg;
                double racaoOxigenio = widget.tripulantes * dias * 2.5;
                double custoOxigenio = racaoOxigenio * 50;
                double orcamentoTotal = custoCombustivel + custoOxigenio;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tela3(
                      nome: widget.nome,
                      tripulantes: widget.tripulantes,
                      distancia: widget.distancia,
                      dias: dias,
                      custoCombustivel: custoCombustivel,
                      custoOxigenio: custoOxigenio,
                      orcamentoTotal: orcamentoTotal,
                    ),
                  ),
                );
              },
              child: const Text('Avançar para Gestão de Risco'),
            ),
          ],
        ),
      ),
    );
  }
}


class Tela3 extends StatefulWidget {
  final String nome;
  final int tripulantes;
  final double distancia;
  final int dias;
  final double custoCombustivel;
  final double custoOxigenio;
  final double orcamentoTotal;

  const Tela3({
    super.key,
    required this.nome,
    required this.tripulantes,
    required this.distancia,
    required this.dias,
    required this.custoCombustivel,
    required this.custoOxigenio,
    required this.orcamentoTotal,
  });

  @override
  State<Tela3> createState() => _Tela3State();
}

class _Tela3State extends State<Tela3> {
  final _orcamentoDispController = TextEditingController();
  final _velocidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 3: Gestão de Risco')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _orcamentoDispController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Orçamento Disponível '),
            ),
            TextField(
              controller: _velocidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Velocidade dos Motores (1 a 100)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double? orcamentoDisp = double.tryParse(_orcamentoDispController.text);
                double? velocidade = double.tryParse(_velocidadeController.text);

                if (orcamentoDisp == null || velocidade == null || velocidade < 1 || velocidade > 100) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insira valores válidos[cite: 3].')),
                  );
                  return;
                }

                // Cálculos obrigatórios[cite: 3]
                double saldoFinal = orcamentoDisp - widget.orcamentoTotal;
                double fatorDesgaste = (velocidade / 10) * widget.dias;
                bool riscoPane = velocidade > 80;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tela4(
                      nome: widget.nome,
                      tripulantes: widget.tripulantes,
                      distancia: widget.distancia,
                      dias: widget.dias,
                      custoCombustivel: widget.custoCombustivel,
                      custoOxigenio: widget.custoOxigenio,
                      orcamentoTotal: widget.orcamentoTotal,
                      orcamentoDisp: orcamentoDisp,
                      saldoFinal: saldoFinal,
                      fatorDesgaste: fatorDesgaste,
                      velocidade: velocidade,
                      riscoPane: riscoPane,
                    ),
                  ),
                );
              },
              child: const Text('Ver Relatório Final'),
            ),
          ],
        ),
      ),
    );
  }
}


class Tela4 extends StatelessWidget {
  final String nome;
  final int tripulantes;
  final double distancia;
  final int dias;
  final double custoCombustivel;
  final double custoOxigenio;
  final double orcamentoTotal;
  final double orcamentoDisp;
  final double saldoFinal;
  final double fatorDesgaste;
  final double velocidade;
  final bool riscoPane;

  const Tela4({
    super.key,
    required this.nome,
    required this.tripulantes,
    required this.distancia,
    required this.dias,
    required this.custoCombustivel,
    required this.custoOxigenio,
    required this.orcamentoTotal,
    required this.orcamentoDisp,
    required this.saldoFinal,
    required this.fatorDesgaste,
    required this.velocidade,
    required this.riscoPane,
  });

  @override
  Widget build(BuildContext context) {
    // Status final da missão[cite: 3]
    String statusFinal = (saldoFinal >= 0 && velocidade <= 80)
        ? "Missão Concluída com Sucesso[cite: 3]"
        : "Missão Resgatada com Avarias[cite: 3]";

    return Scaffold(
      appBar: AppBar(title: const Text('Tela 4: Relatório Final')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Comandante: $nome[cite: 3]'),
            Text('Tripulantes: $tripulantes[cite: 3]'),
            Text('Distância: $distancia Anos-Luz[cite: 3]'),
            Text('Dias: $dias[cite: 3]'),
            Text('Custo Combustível: \$${custoCombustivel.toStringAsFixed(2)}[cite: 3]'),
            Text('Custo Oxigênio: \$${custoOxigenio.toStringAsFixed(2)}[cite: 3]'),
            Text('Orçamento Total: \$${orcamentoTotal.toStringAsFixed(2)}[cite: 3]'),
            Text('Orçamento Disponível: \$${orcamentoDisp.toStringAsFixed(2)}[cite: 3]'),
            Text(
              'Saldo Final: \$${saldoFinal.toStringAsFixed(2)}[cite: 3]',
              style: TextStyle(
                color: saldoFinal < 0 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (saldoFinal < 0)
              const Text('Risco Crítico de Falência Financeira[cite: 3]', style: TextStyle(color: Colors.red)),
            if (riscoPane)
              const Text('Alerta: Risco de Pane (Velocidade > 80%)[cite: 3]', style: TextStyle(color: Colors.orange)),
            Text('Fator de Desgaste: ${fatorDesgaste.toStringAsFixed(2)}[cite: 3]'),
            Text('Status Final: $statusFinal', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retorna à Tela 1 limpando a pilha de navegação[cite: 4, 5]
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Tela1()),
                  (route) => false,
                );
              },
              child: const Text('Reiniciar Missão'),
            ),
          ],
        ),
      ),
    );
  }
}