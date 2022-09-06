class TodoModel {
  String? id;
  String? title;
  String? description;

  TodoModel(this.title, this.description, this.id);

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }
}
