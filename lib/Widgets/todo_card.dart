import 'package:flutter/material.dart';
import 'package:todo_project/models/todo_model.dart';


// ignore: must_be_immutable
class ToDoCard extends StatefulWidget {
  // todocard'da veri alacak değişkenler oluşturun
  final int id;
  final String title;
  final DateTime creationDate;
  bool isChecked;

  final Function insertFunction;
  final Function deleteFunction;

  ToDoCard({
    Key? key,
    required this.id,
    required this.creationDate,
    required this.title,
    required this.deleteFunction, // delete butonunu halledeck
    required this.insertFunction, //checkbox taki değişikleri halledecek
    required this.isChecked,
  }) : super(key: key);

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    //local bir to do oluştur.
    var anotherToDo = ToDo(
      id: widget.id,
      title: widget.title,
      creationDate: widget.creationDate,
      isChecked: widget.isChecked,
    );
    return Card(
      child: Row(
        children: [
          //burası checkbox olacak
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Checkbox(
              value: widget.isChecked,
              onChanged: (bool? value) {
                setState(() {
                  widget.isChecked = value!;
                });
                //anotherToDo da isChecked in değerrini değiştir.
                anotherToDo.isChecked = value!;
                // database e ekle
                widget.insertFunction(anotherToDo);
              },
            ),
            
          ),
          // burası title ve date kısmı
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.creationDate.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:  Color(0xFF8F8F8F),
                  ),
                ),
              ],
            ),
          ),
          //bu kısım silme butonu olacak
          IconButton(
            onPressed: () {
              //delete methodunu ekle
              widget.deleteFunction(anotherToDo);
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
    );
  }
}
