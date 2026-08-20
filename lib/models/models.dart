import 'dart:convert';

enum TaskStatus { todo, inProgress, done }
enum TaskPriority { low, medium, high, critical }

String enumName(Object value) => value.toString().split('.').last;
TaskStatus taskStatusFrom(String value) => TaskStatus.values.firstWhere((e) => enumName(e) == value, orElse: () => TaskStatus.todo);
TaskPriority priorityFrom(String value) => TaskPriority.values.firstWhere((e) => enumName(e) == value, orElse: () => TaskPriority.medium);

class Label {
  String id, name, color, description;
  Label({required this.id, required this.name, required this.color, this.description = ''});
  Map<String,dynamic> toJson()=>{'id':id,'name':name,'color':color,'description':description};
  factory Label.fromJson(Map<String,dynamic> j)=>Label(id:j['id'],name:j['name'],color:j['color'],description:j['description']??'');
}
class Subtask { String id,title; bool done; Subtask({required this.id,required this.title,this.done=false}); Map<String,dynamic> toJson()=>{'id':id,'title':title,'done':done}; factory Subtask.fromJson(Map<String,dynamic> j)=>Subtask(id:j['id'],title:j['title'],done:j['done']??false); }
class Comment { String id,body,author; DateTime createdAt; Comment({required this.id,required this.body,required this.author,required this.createdAt}); Map<String,dynamic> toJson()=>{'id':id,'body':body,'author':author,'createdAt':createdAt.toIso8601String()}; factory Comment.fromJson(Map<String,dynamic> j)=>Comment(id:j['id'],body:j['body'],author:j['author'],createdAt:DateTime.parse(j['createdAt'])); }
class Task {
  String id,title,description,projectId,milestoneId; TaskStatus status; TaskPriority priority; List<String> labelIds; DateTime? dueDate; List<Subtask> subtasks; List<Comment> comments;
  Task({required this.id,required this.title,required this.description,this.projectId='',this.milestoneId='',this.status=TaskStatus.todo,this.priority=TaskPriority.medium,this.labelIds=const [],this.dueDate,this.subtasks=const [],this.comments=const []});
  Map<String,dynamic> toJson()=>{'id':id,'title':title,'description':description,'projectId':projectId,'milestoneId':milestoneId,'status':enumName(status),'priority':enumName(priority),'labelIds':labelIds,'dueDate':dueDate?.toIso8601String(),'subtasks':subtasks.map((e)=>e.toJson()).toList(),'comments':comments.map((e)=>e.toJson()).toList()};
  factory Task.fromJson(Map<String,dynamic> j)=>Task(id:j['id'],title:j['title'],description:j['description']??'',projectId:j['projectId']??'',milestoneId:j['milestoneId']??'',status:taskStatusFrom(j['status']??'todo'),priority:priorityFrom(j['priority']??'medium'),labelIds:List<String>.from(j['labelIds']??[]),dueDate:j['dueDate']==null?null:DateTime.parse(j['dueDate']),subtasks:(j['subtasks'] as List? ?? []).map((e)=>Subtask.fromJson(e)).toList(),comments:(j['comments'] as List? ?? []).map((e)=>Comment.fromJson(e)).toList());
}
class Project { String id,name,description,color; List<String> taskIds; String milestoneId; Project({required this.id,required this.name,required this.description,required this.color,this.taskIds=const [],this.milestoneId=''}); Map<String,dynamic> toJson()=>{'id':id,'name':name,'description':description,'color':color,'taskIds':taskIds,'milestoneId':milestoneId}; factory Project.fromJson(Map<String,dynamic> j)=>Project(id:j['id'],name:j['name'],description:j['description']??'',color:j['color']??'#2da44e',taskIds:List<String>.from(j['taskIds']??[]),milestoneId:j['milestoneId']??''); }
class Milestone { String id,title,description; DateTime? dueDate; Milestone({required this.id,required this.title,required this.description,this.dueDate}); Map<String,dynamic> toJson()=>{'id':id,'title':title,'description':description,'dueDate':dueDate?.toIso8601String()}; factory Milestone.fromJson(Map<String,dynamic> j)=>Milestone(id:j['id'],title:j['title'],description:j['description']??'',dueDate:j['dueDate']==null?null:DateTime.parse(j['dueDate'])); }
class Workspace { String name,description; List<Task> tasks; List<Project> projects; List<Milestone> milestones; List<Label> labels; Workspace({required this.name,required this.description,required this.tasks,required this.projects,required this.milestones,required this.labels}); Map<String,dynamic> toJson()=>{'name':name,'description':description,'tasks':tasks.map((e)=>e.toJson()).toList(),'projects':projects.map((e)=>e.toJson()).toList(),'milestones':milestones.map((e)=>e.toJson()).toList(),'labels':labels.map((e)=>e.toJson()).toList()}; String encode()=>jsonEncode(toJson()); factory Workspace.fromJson(Map<String,dynamic> j)=>Workspace(name:j['name'],description:j['description']??'',tasks:(j['tasks'] as List).map((e)=>Task.fromJson(e)).toList(),projects:(j['projects'] as List).map((e)=>Project.fromJson(e)).toList(),milestones:(j['milestones'] as List).map((e)=>Milestone.fromJson(e)).toList(),labels:(j['labels'] as List).map((e)=>Label.fromJson(e)).toList()); }
