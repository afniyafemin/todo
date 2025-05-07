import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/constants/images.dart';
import 'package:todo/widgets/todo_item.dart';
import '../main.dart';
import '../provider/todo_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController todoController = TextEditingController();

  @override
  void dispose(){
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.secondaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu,size: 30,color: Colors.black,semanticLabel: "menu",),
            CircleAvatar(
              backgroundImage: AssetImage(ImageConstant.profile),
            )
          ],
        ),
      ),
      body: Padding(
        padding:EdgeInsets.all(width*0.03),
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(width*0.05)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(width*0.05)
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              cursorColor: Colors.black,
            ),
            SizedBox(height: height*0.015,),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.all(width*0.03),
                  child: Text("All TODOs",
                    style: TextStyle(
                        fontSize: width*0.065,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, value, child) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final todo = value.todos[index];
                        return TodoItem(todo: todo);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: height*0.02,);
                      },
                      itemCount: value.todos.length
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height*0.065,
                  width: width*0.65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width*0.025),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.secondaryColor.withOpacity(0.45),
                        spreadRadius: width*0.0001,
                        blurRadius: width*0.025
                      )
                    ]
                  ),
                  child: TextFormField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: "add more todo item...",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: width*0.035
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none
                      )
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (todoController.text.trim().isNotEmpty) {
                      Provider.of<TodoProvider>(context,listen: false).addTodo(todoController.text);
                      todoController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Todo Added"))
                      );
                    }
                  },
                  child: Container(
                    height: height*0.065,
                    width: width*0.15,
                    decoration: BoxDecoration(
                      color: ColorConstant.secondaryColor,
                      borderRadius: BorderRadius.circular(width*0.025)
                    ),
                    child: Center(
                      child: Icon(Icons.done,color: Colors.white,size: width*0.085,semanticLabel: "add todo",),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
}

