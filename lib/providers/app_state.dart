import 'package:flutter/material.dart';
import '../models/models.dart';
import '../repositories/workspace_repository.dart';
class AppState extends ChangeNotifier {
  final repo=WorkspaceRepository(); Workspace workspace; ThemeMode themeMode=ThemeMode.dark; Color accent=const Color(0xFF2DA44E); int page=0;
  AppState(this.workspace);
  static Future<AppState> create(Workspace demo) async { final loaded=await WorkspaceRepository().load(); return AppState(loaded??demo); }
  Future<void> save(){ notifyListeners(); return repo.save(workspace); }
  void setTheme(ThemeMode m){themeMode=m;notifyListeners();}
  void setAccent(Color c){accent=c;notifyListeners();}
  void setPage(int p){page=p;notifyListeners();}
}
