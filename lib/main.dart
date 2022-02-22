// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do-List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = <String>[];
  final List<String> _description = <String>[];
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayDialog(context),
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  void addTodoItem(String title, String discription) {
    //Wrapping it inside a set state will notify
    // the app that the state has changed

    setState(() {
      _todoList.add(title);
      _description.add(discription);
    });
    _title.clear();
    _desc.clear();
  }

  //Generate list of item widgets
  Widget buildTodoItem(String title, String discription) {
    return Card(
      color: Colors.blueAccent,
      child: ListTile(
        title: Text(title),
        subtitle: Text(discription),
      ),
    );
  }

  //Generate a single item widget
  displayDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // title: const Text('Add a task to your List'),
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      'Add TO-DO-List',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    controller: _title,
                    decoration: const InputDecoration(
                      hintText: 'Enter task here',
                    ),
                  ),
                  TextField(
                    controller: _desc,
                    decoration: const InputDecoration(
                      hintText: 'Enter description here',
                    ),
                  ),
                  Row(
                    children: [
                      FlatButton(
                        child: const Text('ADD'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          addTodoItem(_title.text, _desc.text);
                        },
                      ),
                      FlatButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _desc.clear();
                          _title.clear();
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (var i = 0; i < _todoList.length; i++) {
      _todoWidgets.add(buildTodoItem(_todoList[i], _description[i]));
    }
    return _todoWidgets;
  }
}
