import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'tugas_model.dart';

class HalamanForm extends StatefulWidget {
  const HalamanForm({super.key});

  @override
  State<HalamanForm> createState() => _HalamanFormState();
}

class _HalamanFormState extends State<HalamanForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judul;
  late final TextEditingController _matkul;
  late final TextEditingController _tanggal;
  DateTime? _tenggat;

  @override
  void initState() {
    super.initState();
    // Controller dibuat di initState
    _judul = TextEditingController();
    _matkul = TextEditingController();
    _tanggal = TextEditingController();
  }

  @override
  void dispose() {
    // ...dan wajib dibuang di dispose
    _judul.dispose();
    _matkul.dispose();
    _tanggal.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final sekarang = DateTime.now();
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tenggat ?? sekarang,
      firstDate: sekarang,
      lastDate: sekarang.add(const Duration(days: 365)),
    );
    if (hasil == null || !mounted) return; // cek mounted setelah await
    setState(() {
      _tenggat = hasil;
      _tanggal.text = '${hasil.day}/${hasil.month}/${hasil.year}';
    });
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    context.read<TugasModel>().tambah(
          _judul.text.trim(),
          _matkul.text.trim(),
          _tenggat!, // aman: validator tanggal sudah lulus
        );
    context.pop(); // kembali ke daftar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _judul,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Judul tugas',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v ?? '').trim().isEmpty ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _matkul,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Mata kuliah',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v ?? '').trim().isEmpty ? 'Mata kuliah wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tanggal,
                readOnly: true,
                onTap: _pilihTanggal,
                decoration: const InputDecoration(
                  labelText: 'Tenggat',
                  prefixIcon: Icon(Icons.event),
                  border: OutlineInputBorder(),
                ),
                // Periksa variabel State, bukan teks (field ini readOnly)
                validator: (_) =>
                    _tenggat == null ? 'Pilih tanggal tenggat' : null,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _simpan,
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}