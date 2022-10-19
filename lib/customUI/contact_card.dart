import 'package:flutter/material.dart';
import 'package:watsapp_clone/model/chat_model.dart';

class ContactCard extends StatelessWidget {
  final ChatModel? contact;
  const ContactCard({Key? key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey[200],
              child: const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ),
            contact!.select
                ? const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(
        contact!.name!,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        contact!.status!,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
