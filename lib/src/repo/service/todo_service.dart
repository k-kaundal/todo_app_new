import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_new/src/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoService {
  CollectionReference ref = FirebaseFirestore.instance.collection("Todo");

  Future<String> addTodo(TodoModel todoModel, String id) async {
    await ref.doc(id.toString()).set(todoModel.toMap());
    return id;
  }

  Stream<QuerySnapshot> getTodos() => ref.snapshots();

  Future<DocumentSnapshot> getTodo(String id) async {
    // Map<String, dynamic> toData = snapshot.data!.data() as Map<String, dynamic>;
    return await ref.doc(id).get();;
  }

  Future<bool> checkTodo(String id) async {
    bool isCorrect = false;
    // List<DocumentSnapshot> data = [];
    await ref.get().then((value) {
      value.docs.forEach((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.id == id) {
          isCorrect = true;
        }
      });
    });
    // Map<String, dynamic> toData = snapshot.data!.data() as Map<String, dynamic>;
    return isCorrect;
  }

  Future<Stream> deleteTodo(String id) async {
    return ref.doc(id).delete().asStream();
  }
 Future<Stream> updateStatus(String id,value) async{
    return ref.doc(id).update({'isCheck':value}).asStream();
  }
}
