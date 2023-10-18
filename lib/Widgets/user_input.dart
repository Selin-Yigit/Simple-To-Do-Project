import 'package:flutter/material.dart';
import 'package:todo_project/models/todo_model.dart';

// ignore: must_be_immutable
class UserInput extends StatelessWidget {
  var textController = TextEditingController();
  final Function insertFunction; // addItem fonksiyonunu alacak
  UserInput({Key? key, required this.insertFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      color: const Color.fromARGB(239, 255, 255, 255),
      child: Row(
        children: [
          //bu input text kısmı olacak
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: "Add a ToDo",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          // bursı butonu oluşturduğumuz kısım
          GestureDetector(
            onTap: () {
              //to do oluştur.
              var myToDo = ToDo(
                title: textController.text,
                creationDate: DateTime.now(),
                isChecked: false,
              );
              // bunu insertfunctiona parametre olarak at. bu gidip homepage deki addItem fonksiyonunu tetikleyecek.
              insertFunction(myToDo);
            },
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: const Text(
                "Add",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
