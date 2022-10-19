import 'package:flutter/material.dart';
import 'package:watsapp_clone/model/chat_model.dart';
import 'package:watsapp_clone/screens/individual_page.dart';

class CustomCard extends StatelessWidget {
  ChatModel? chatModel;
  CustomCard({Key? key, String? currentMessage, this.chatModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      chatModel: chatModel!,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Icon(chatModel!.isGroup! ? Icons.group : Icons.person,
                  size: 30),
            ),
            title: Text(
              "${chatModel!.name}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.done_all,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  chatModel!.currentMessage!,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            trailing: Text(chatModel!.time!),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 80, right: 20),
            child: Divider(
              height: 5,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
