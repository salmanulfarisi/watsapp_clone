import 'package:flutter/material.dart';
import 'package:watsapp_clone/customUI/custom_card.dart';
import 'package:watsapp_clone/model/chat_model.dart';
import 'package:watsapp_clone/screens/select_contact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        name: "Salman",
        icon: "S",
        isGroup: false,
        time: "12:00",
        currentMessage: "Hello"),
    ChatModel(
      name: "Shabeeb",
      icon: "S",
      isGroup: false,
      time: "4:00",
      currentMessage: "Hi, How are you?",
    ),
    ChatModel(
        name: "Server Chat Group",
        icon: "S",
        isGroup: true,
        time: "4:00",
        currentMessage: "Hi, How are you?"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: chats[index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SelectContact()));
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
