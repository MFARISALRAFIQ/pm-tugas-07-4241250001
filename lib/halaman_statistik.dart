import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'tugas_model.dart';

class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});

  @override
  Widget build(BuildContext context) {
    final m = context.watch<TugasModel>(); // otomatis ikut berubah
    final teks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Kartu(label: 'Total tugas', nilai: '${m.total}', gaya: teks),
          _Kartu(label: 'Selesai', nilai: '${m.jumlahSelesai}', gaya: teks),
          _Kartu(
            label: 'Persentase selesai',
            nilai: '${m.persenSelesai.toStringAsFixed(0)}%',
            gaya: teks,
          ),
        ],
      ),
    );
  }
}

class _Kartu extends StatelessWidget {
  const _Kartu({required this.label, required this.nilai, required this.gaya});

  final String label;
  final String nilai;
  final TextTheme gaya;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(nilai, style: gaya.headlineSmall),
      ),
    );
  }
}