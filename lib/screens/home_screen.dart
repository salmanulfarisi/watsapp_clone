import 'package:flutter/material.dart';
import 'package:watsapp_clone/pages/chat_pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff075E54),
        title: const Text('WhatsApp'),
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
                value: "New group",
                child: Text('New group'),
              ),
              const PopupMenuItem(
                value: "New broadcast",
                child: Text('New broadcast'),
              ),
              const PopupMenuItem(
                value: "WhatsApp Web",
                child: Text('WhatsApp Web'),
              ),
              const PopupMenuItem(
                value: "Starred messages",
                child: Text('Starred messages'),
              ),
              const PopupMenuItem(
                value: "Settings",
                child: Text('Settings'),
              ),
            ];
          })
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: 'CHATS',
            ),
            Tab(
              text: 'STATUS',
            ),
            Tab(
              text: 'CALLS',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          Center(
            child: Text('Camera'),
          ),
          ChatPage(),
          Center(
            child: Text('Status'),
          ),
          Center(
            child: Text('Calls'),
          ),
        ],
      ),
    );
  }
}
