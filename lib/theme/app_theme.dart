import 'package:flutter/material.dart';
class AppTheme {
  static const githubGreen=Color(0xFF2DA44E), darkBg=Color(0xFF0D1117), darkPanel=Color(0xFF161B22), darkBorder=Color(0xFF30363D), darkText=Color(0xFFE6EDF3), darkMuted=Color(0xFF8B949E);
  static ThemeData light(Color accent)=>ThemeData(useMaterial3:true,brightness:Brightness.light,colorScheme:ColorScheme.fromSeed(seedColor:accent,brightness:Brightness.light),scaffoldBackgroundColor:const Color(0xFFF6F8FA),cardColor:Colors.white,dividerColor:const Color(0xFFD0D7DE),inputDecorationTheme:const InputDecorationTheme(border:OutlineInputBorder(),filled:true,fillColor:Colors.white),appBarTheme:const AppBarTheme(elevation:0,backgroundColor:Colors.white));
  static ThemeData dark(Color accent)=>ThemeData(useMaterial3:true,brightness:Brightness.dark,colorScheme:ColorScheme.fromSeed(seedColor:accent,brightness:Brightness.dark),scaffoldBackgroundColor:darkBg,cardColor:darkPanel,dividerColor:darkBorder,inputDecorationTheme:const InputDecorationTheme(border:OutlineInputBorder(),filled:true,fillColor:darkPanel),appBarTheme:const AppBarTheme(elevation:0,backgroundColor:darkBg));
}
