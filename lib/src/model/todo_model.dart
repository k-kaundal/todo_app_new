class TodoModel {
  String? id;
  String? title;
  String? description;
  bool? isCheck;
  String? date;
  String? time;
  bool? isImportant;

  TodoModel(this.title, this.description, this.id, this.isCheck, this.date,
      this.time,this.isImportant);

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isCheck = json['isCheck'];
    date = json['date'];
    time = json['time'];
    isImportant = json['isImportant'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCheck': isCheck,
      'date':date,
      'time':time,
      'isImportant':isImportant
    };
  }
}


class TodoTypeModel{
  String? name;
  String? value;
  TodoTypeModel(this.name,this.value);
  TodoTypeModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    value=json['value'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'value':value
    };
  }
}
