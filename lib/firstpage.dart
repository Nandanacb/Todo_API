import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/datamodel.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});
  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  bool _isloading = true;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  TodomodelApi? dataFromAPI;

  _getData() async {
    try {
      String url = "https://dummyjson.com/todos";

      http.Response res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        dataFromAPI = TodomodelApi?.fromJson(json.decode(res.body));
        _isloading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 216, 109, 145),
        title: Text("TODO API"),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : dataFromAPI == null
              ? const Center(
                  child: Text('Failed to load data'),
                )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final Todo = dataFromAPI!.todos[index];
                        return Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 248, 236, 236)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Id:${Todo.id}",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Todo:${Todo.todo}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                                SizedBox(height: 10),
                                Text("Completed:${Todo.completed}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                                SizedBox(height: 10),
                                Text("User id:${Todo.userId}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 15,
                        );
                      },
                      itemCount: dataFromAPI!.todos.length),
                ),
    );
  }
}
