import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'halaman_daftar.dart';
import 'halaman_form.dart';
import 'halaman_statistik.dart';
import 'tugas_model.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => TugasModel(), // satu objek untuk seluruh aplikasi
        child: const PlannerApp(),
      ),
    );

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => KerangkaNavigasi(shell: shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/', builder: (c, s) => const HalamanDaftar()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/statistik', builder: (c, s) => const HalamanStatistik()),
        ]),
      ],
    ),
    // Di luar shell: tampil layar penuh di atas navigasi
    GoRoute(path: '/tambah', builder: (c, s) => const HalamanForm()),
  ],
);

class PlannerApp extends StatelessWidget {
  const PlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Planner Kuliah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3949AB)),
      ),
      routerConfig: _router,
    );
  }
}

class KerangkaNavigasi extends StatelessWidget {
  const KerangkaNavigasi({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    // select: rebuild hanya bila jumlahAktif berubah
    final aktif = context.select((TugasModel m) => m.jumlahAktif);

    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        destinations: [
          NavigationDestination(
            icon: Badge.count(
              count: aktif,
              isLabelVisible: aktif > 0,
              child: const Icon(Icons.checklist),
            ),
            label: 'Tugas',
          ),
          const NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
        ],
      ),
    );
  }
}