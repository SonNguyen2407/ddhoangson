import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'api.dart';
import 'auth_page.dart';
import 'home_page.dart';
import 'ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AttendlyApp(api: Api()..restore()));
}

class AttendlyApp extends StatelessWidget {
  final Api api;
  const AttendlyApp({required this.api, super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Attendly · Điểm danh sinh viên',
    locale: const Locale('vi'),
    supportedLocales: const [Locale('vi'), Locale('en')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff14745f))
          .copyWith(
            primary: const Color(0xff14745f),
            secondary: const Color(0xff77c9aa),
            surface: const Color(0xfffbfdfb),
          ),
      scaffoldBackgroundColor: const Color(0xfff3f7f5),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 15, color: Color(0xff344740)),
        bodySmall: TextStyle(fontSize: 13, color: Color(0xff718078)),
        titleMedium: TextStyle(
          fontSize: 16,
          color: Color(0xff18342f),
          fontWeight: FontWeight.w700,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xfff3f7f5),
        foregroundColor: navy,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xfff5f8f6),
        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Color(0xffe5ece8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Color(0xff14745f), width: 1.6),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 50),
          side: const BorderSide(color: Color(0xffd9e5df)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 14),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: Color(0xffe7eeea)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 78,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xffdef3e9),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        elevation: 3,
        shadowColor: const Color(0x1a18342f),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? const Color(0xff14745f)
                : const Color(0xff75847d),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: const Color(0xff46645a),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(44, 44),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Color(0xff14745f),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        minVerticalPadding: 10,
      ),
    ),
    home: ListenableBuilder(
      listenable: api,
      builder: (_, _) => !api.restored
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : api.user == null
          ? AuthPage(api: api)
          : HomePage(key: ValueKey(api.user!['id']), api: api),
    ),
  );
}
