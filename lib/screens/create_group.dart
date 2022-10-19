import 'package:flutter/material.dart';
import 'package:watsapp_clone/customUI/avathar_card.dart';
import 'package:watsapp_clone/customUI/contact_card.dart';
import 'package:watsapp_clone/model/chat_model.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: 'Kunjutty', status: "Flutter Devolper"),
    ChatModel(name: 'Shabeeb', status: "Python Devolper"),
    ChatModel(name: 'Ameen', status: "MERN Devolper"),
    ChatModel(name: 'Kunjutty', status: "Flutter Devolper"),
    ChatModel(name: 'Shabeeb', status: "Python Devolper"),
    ChatModel(name: 'Ameen', status: "MERN Devolper"),
  ];
  List<ChatModel> groupMembers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff075E54),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('New group',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              'Add participants',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groupMembers.isNotEmpty ? 80 : 10,
                );
              }
              return InkWell(
                onTap: () {
                  setState(() {
                    if (contacts[index - 1].select == false) {
                      setState(() {
                        contacts[index - 1].select = true;
                        groupMembers.add(contacts[index - 1]);
                      });
                    } else {
                      setState(() {
                        contacts[index - 1].select = false;
                        groupMembers.remove(contacts[index - 1]);
                      });
                    }
                  });
                },
                child: ContactCard(
                  contact: contacts[index - 1],
                ),
              );
            },
          ),
          groupMembers.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      width: double.infinity,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].select == true) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  contacts[index].select = false;
                                  groupMembers.remove(contacts[index]);
                                });
                              },
                              child: AvatharCard(
                                contact: contacts[index],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
