import 'package:flutter_test/flutter_test.dart';
import 'package:pm_pertemuan_07/tugas_model.dart';

void main() {
  final tenggat = DateTime(2026, 12, 1);

  test('tambah menambah tugas dan memberi tahu pendengar', () {
    final m = TugasModel();
    var notifikasi = 0;
    m.addListener(() => notifikasi++);
    m.tambah('Laporan', 'Mobile', tenggat);
    expect(m.total, 1);
    expect(m.jumlahAktif, 1);
    expect(notifikasi, 1);
  });

  test('alihSelesai mengubah statistik', () {
    final m = TugasModel()
      ..tambah('A', 'Mobile', tenggat)
      ..tambah('B', 'Basis Data', tenggat);
    m.alihSelesai(1);
    expect(m.jumlahSelesai, 1);
    expect(m.persenSelesai, 50);
  });

  test('hapus menghilangkan tugas dan persen aman saat kosong', () {
    final m = TugasModel()..tambah('A', 'Mobile', tenggat);
    m.hapus(1);
    expect(m.total, 0);
    expect(m.persenSelesai, 0);
  });
}