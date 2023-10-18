import 'package:flutter/material.dart';
import 'package:todo_project/models/db_model.dart';
import 'package:todo_project/Widgets/todo_card.dart';

// ignore: must_be_immutable
class ToDoList extends StatelessWidget {
  //silme işlemini yapabilmek için bilgileri todo card a atmalıyız. bunun için to do list fonksiyonları almalı.

  final Function insertFunction;
  final Function deleteFunction;
  var db = DatabaseConnect();
  ToDoList({Key? key,required this.insertFunction, required this.deleteFunction }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: FutureBuilder(
        future: db.getToDo(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data =
              snapshot.data; // bu göstermemiz gereken data (to do listesi)
          var datalength = data!.length;

          return datalength == 0
              // ignore: prefer_const_constructors
              ? Center(
                  child: const Text('veri bulunamadı...'),
                )
              : ListView.builder(
                  //shrinkWrap: true,
                  itemCount: datalength,
                  itemBuilder: (context, i) => ToDoCard(
                      id: data[i].id,
                      creationDate: data[i].creationDate,
                      title: data[i].title,
                      deleteFunction: deleteFunction,
                      insertFunction: insertFunction,
                      isChecked: data[i].isChecked),
                  shrinkWrap: true,
                );
        },
      ),
    );
  }
}
