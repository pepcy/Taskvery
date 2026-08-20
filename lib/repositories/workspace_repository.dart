import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
class WorkspaceRepository {
  static const key='task_manager_workspace_v1';
  Future<Workspace?> load() async { final p=await SharedPreferences.getInstance(); final raw=p.getString(key); if(raw==null)return null; try { return Workspace.fromJson(Map<String,dynamic>.from(jsonDecode(raw))); } catch(_){ return null; } }
  Future<void> save(Workspace w) async { final p=await SharedPreferences.getInstance(); await p.setString(key,w.encode()); }
  Future<void> clear() async { final p=await SharedPreferences.getInstance(); await p.remove(key); }
}
