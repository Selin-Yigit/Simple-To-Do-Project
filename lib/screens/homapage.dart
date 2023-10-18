import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:matcher/matcher.dart';
import 'package:todo_project/Widgets/user_input.dart';
import 'package:todo_project/Widgets/todo_card.dart';
import 'package:todo_project/Widgets/todo_list.dart';
import 'package:todo_project/models/db_model.dart';
import 'package:todo_project/models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // fonksiyonları burada oluşturmalıyız çünkü burada iki widget iletişim kurabilir.

  // database bağlantısı için nesne oluştur. çünü database fonksiyonlarına ulaşacaksın.
  var db = DatabaseConnect();

  // to do eklemek için fonksiyon
  void addItem(ToDo toDo) async {
    await db.insertTodo(toDo);
    setState(() {});
  }

  // silme fonksiyonu
  void deleteItem(ToDo toDo) async {
    await db.deleteTodo(toDo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("To Do App"),
      ),
      body: Column(
        children: [
          //widget ları buaraya ekleyeceğiz.
          ToDoList(
            insertFunction: addItem,
            deleteFunction: deleteItem,
          ),
          UserInput(insertFunction: addItem),
        ],
      ),
    );
  }
}
