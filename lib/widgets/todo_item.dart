import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screens/home_screen.dart';

import '../main.dart';
import '../provider/todo_provider.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: height*0.015),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(width*0.05)
      ),
      child: ListTile(
        title: Text(this.todo.title,
          style: TextStyle(
            decoration: todo.isCompleted?TextDecoration.lineThrough:null,
            fontWeight: FontWeight.w500,
            fontSize: width*0.04
          ),
        ),

        leading: Checkbox(
            onChanged: (value) {
              Provider.of<TodoProvider>(context,listen: false).toggleCompletion(todo);
            }, value: todo.isCompleted,
        ),


        trailing: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
              return AlertDialog(
                title: Text("Delete the Todo item ?"),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<TodoProvider>(context,listen: false).removeTodo(todo);
                      Navigator.pop(context);
                    },
                    child: Text("delete",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  )
                ],
              );
            },
            );
          },
          child: Container(
            height: height*0.035,
            width: height*0.035,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(width*0.02)
            ),
            child: Center(child: Icon(Icons.delete,size: width*0.045,color: Colors.white,),),
          ),
        ),
      ),
    );
  }
}
