import 'package:flutter/material.dart';
import 'package:watsapp_clone/model/chat_model.dart';

class AvatharCard extends StatelessWidget {
  final ChatModel contact;
  const AvatharCard({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blueGrey[200],
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.clear,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            contact.name!,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
