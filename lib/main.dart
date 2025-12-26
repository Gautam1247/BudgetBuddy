import 'package:budgetbuddy/widgets/expenses.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

var kcolorscheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);
var kdarkcolorscheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 5, 99, 125),
);
void main() {
 // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
  //   fn,
  // ) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kdarkcolorscheme,
          cardTheme: CardThemeData().copyWith(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: kdarkcolorscheme.secondaryContainer,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kdarkcolorscheme.primaryContainer,
              foregroundColor: kdarkcolorscheme.onPrimaryContainer,
            ),
          ),
          textTheme: TextTheme().copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: kcolorscheme.onSecondaryContainer,
            ),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: kcolorscheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kcolorscheme.onPrimaryContainer,
            foregroundColor: kcolorscheme.primaryContainer,
          ),
          cardTheme: CardThemeData().copyWith(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: kcolorscheme.secondaryContainer,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcolorscheme.primaryContainer,
            ),
          ),
          textTheme: TextTheme().copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: kcolorscheme.onSecondaryContainer,
            ),
          ),
        ),

        home: Expenses(),
      ),
    );
  // });
}
