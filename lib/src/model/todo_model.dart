class TodoModel {
  String? id;
  String? title;
  String? description;
  bool? isCheck;

  TodoModel(this.title, this.description, this.id,this.isCheck);

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description,'isCheck':isCheck};
  }
}
