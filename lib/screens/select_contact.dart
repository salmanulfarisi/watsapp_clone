import 'package:flutter/material.dart';
import 'package:watsapp_clone/customUI/button_card.dart';
import 'package:watsapp_clone/customUI/contact_card.dart';
import 'package:watsapp_clone/model/chat_model.dart';
import 'package:watsapp_clone/screens/create_group.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(name: 'Kunjutty', status: "Flutter Devolper"),
      ChatModel(name: 'Shabeeb', status: "Python Devolper"),
      ChatModel(name: 'Ameen', status: "MERN Devolper"),
      ChatModel(name: 'Kunjutty', status: "Flutter Devolper"),
      ChatModel(name: 'Shabeeb', status: "Python Devolper"),
      ChatModel(name: 'Ameen', status: "MERN Devolper"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff075E54),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Select contact',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              '1 contact selected',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(onSelected: (value) {
            print(value);
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: "Invite a friend",
                child: Text('Invite a friend'),
              ),
              const PopupMenuItem(
                value: "Contacts",
                child: Text('Contacts'),
              ),
              const PopupMenuItem(
                value: "Refresh",
                child: Text('Refresh'),
              ),
              const PopupMenuItem(
                value: "Help",
                child: Text('Help'),
              ),
            ];
          })
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateGroup()));
                    },
                    child: const ButtonCard(
                      name: "New group",
                      icon: Icons.group,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ButtonCard(
                    name: "New Contact",
                    icon: Icons.person,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }
          return ContactCard(
            contact: contacts[index - 1],
          );
        },
      ),
    );
  }
}
