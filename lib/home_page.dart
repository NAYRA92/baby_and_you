import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String _apiKey = comaiCodeApi;

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (BuildContext){
              return AlertDialog(
                content: Container(
                  height: 350,
                  width: 350,
                  child: Column(
                    children: [
                      Expanded(
                        child: ChatScreen(),
                      ),
                    ],
                  ),
                ),
              );
            });
        },
        tooltip: "Smart Chatbot",
        backgroundColor: kFern_green,
        child: Icon(
          Icons.question_answer,
          color: kHoneydew,
        ),),
    );
  }
}