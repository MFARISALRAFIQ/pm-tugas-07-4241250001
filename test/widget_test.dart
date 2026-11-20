import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pm_pertemuan_07/main.dart';
import 'package:pm_pertemuan_07/tugas_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Form kosong menampilkan pesan error', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TugasModel(),
        child: const PlannerApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Belum ada tugas'), findsOneWidget);

    // Buka form lewat tombol +
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Simpan dalam keadaan kosong
    await tester.tap(find.text('Simpan'));
    await tester.pump();

    expect(find.text('Judul wajib diisi'), findsOneWidget);
    expect(find.text('Mata kuliah wajib diisi'), findsOneWidget);
    expect(find.text('Pilih tanggal tenggat'), findsOneWidget);
  });
}