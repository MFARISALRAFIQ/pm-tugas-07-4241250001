import 'package:flutter/foundation.dart';
import 'tugas_kuliah.dart';

class TugasModel extends ChangeNotifier {
  final List<TugasKuliah> _daftar = [];
  int _idBerikut = 1;

  List<TugasKuliah> get daftar => List.unmodifiable(_daftar);
  int get total => _daftar.length;
  int get jumlahSelesai => _daftar.where((t) => t.selesai).length;
  int get jumlahAktif => total - jumlahSelesai;
  double get persenSelesai => total == 0 ? 0 : jumlahSelesai / total * 100;

  void tambah(String judul, String matkul, DateTime tenggat) {
    _daftar.add(TugasKuliah(
      id: _idBerikut++,
      judul: judul,
      matkul: matkul,
      tenggat: tenggat,
    ));
    notifyListeners();
  }

  void alihSelesai(int id) {
    final i = _daftar.indexWhere((t) => t.id == id);
    if (i == -1) return;
    _daftar[i] = _daftar[i].copyWith(selesai: !_daftar[i].selesai);
    notifyListeners();
  }

  void hapus(int id) {
    _daftar.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}