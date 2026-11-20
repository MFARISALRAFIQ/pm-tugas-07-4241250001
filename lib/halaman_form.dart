import 'package:material_ui/material_ui.dart';

class HalamanForm extends StatelessWidget {
  const HalamanForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: const Center(child: Text('Form menyusul')),
    );
  }
}