import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'tugas_kuliah.dart';
import 'tugas_model.dart';

enum FilterTugas {
  semua('Semua'),
  aktif('Aktif'),
  selesai('Selesai');

  const FilterTugas(this.label);
  final String label;
}

String formatTanggal(DateTime t) => '${t.day}/${t.month}/${t.year}';

// Stateful hanya untuk filter (ephemeral state)
class HalamanDaftar extends StatefulWidget {
  const HalamanDaftar({super.key});

  @override
  State<HalamanDaftar> createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends State<HalamanDaftar> {
  FilterTugas _filter = FilterTugas.semua;

  List<TugasKuliah> _saring(List<TugasKuliah> semua) => switch (_filter) {
        FilterTugas.semua => semua,
        FilterTugas.aktif => semua.where((t) => !t.selesai).toList(),
        FilterTugas.selesai => semua.where((t) => t.selesai).toList(),
      };

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TugasModel>(); // state bersama
    final tampil = _saring(model.daftar);

    return Scaffold(
      appBar: AppBar(title: const Text('Planner Tugas Kuliah')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              children: [
                for (final f in FilterTugas.values)
                  FilterChip(
                    label: Text(f.label),
                    selected: _filter == f,
                    onSelected: (_) => setState(() => _filter = f),
                  ),
              ],
            ),
          ),
          Expanded(
            child: tampil.isEmpty
                ? const Center(child: Text('Belum ada tugas'))
                : ListView.builder(
                    itemCount: tampil.length,
                    itemBuilder: (context, i) {
                      final t = tampil[i];
                      return ListTile(
                        leading: Checkbox(
                          value: t.selesai,
                          // read di dalam callback: tidak perlu mendengarkan
                          onChanged: (_) =>
                              context.read<TugasModel>().alihSelesai(t.id),
                        ),
                        title: Text(
                          t.judul,
                          style: TextStyle(
                            decoration:
                                t.selesai ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle:
                            Text('${t.matkul} · ${formatTanggal(t.tenggat)}'),
                        trailing: IconButton(
                          tooltip: 'Hapus',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () =>
                              context.read<TugasModel>().hapus(t.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/tambah'),
        icon: const Icon(Icons.add),
        label: const Text('Tugas'),
      ),
    );
  }
}