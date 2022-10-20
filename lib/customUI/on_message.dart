import 'package:flutter/material.dart';

class OnMessageCard extends StatelessWidget {
  const OnMessageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: const Color(0xffdcf8c6),
          child: Stack(
            children: [
              const Text(
                "hey",
                style: TextStyle(fontSize: 16),
              ),
              Positioned(
                right: 0,
                child: Row(
                  children: const [
                    Text("8:00",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffb2b2b2))),
                    Icon(Icons.done_all, size: 12, color: Color(0xffb2b2b2)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
