// To parse this JSON data, do
//
//     final todomodelApi = todomodelApiFromJson(jsonString);

import 'dart:convert';

TodomodelApi todomodelApiFromJson(String str) =>
    TodomodelApi.fromJson(json.decode(str));

String todomodelApiToJson(TodomodelApi data) => json.encode(data.toJson());

class TodomodelApi {
  List<Todo> todos;

  TodomodelApi({
    required this.todos,
  });

  factory TodomodelApi.fromJson(Map<String, dynamic> json) => TodomodelApi(
        todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "todos": List<dynamic>.from(todos.map((x) => x.toJson())),
      };
}

class Todo {
  int id;
  String todo;
  bool completed;
  int userId;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
      };
}
