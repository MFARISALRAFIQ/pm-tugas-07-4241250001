class TugasKuliah {
  const TugasKuliah({
    required this.id,
    required this.judul,
    required this.matkul,
    required this.tenggat,
    this.selesai = false,
  });

  final int id;
  final String judul;
  final String matkul;
  final DateTime tenggat;
  final bool selesai;

  TugasKuliah copyWith({bool? selesai}) => TugasKuliah(
        id: id,
        judul: judul,
        matkul: matkul,
        tenggat: tenggat,
        selesai: selesai ?? this.selesai,
      );
}