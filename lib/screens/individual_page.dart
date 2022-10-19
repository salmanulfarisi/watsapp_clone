import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:watsapp_clone/model/chat_model.dart';

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  const IndividualPage({Key? key, required this.chatModel}) : super(key: key);

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final TextEditingController _controller = TextEditingController();
  bool showEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmojiPicker = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 88,
        backgroundColor: const Color(0xff075E54),
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Text(widget.chatModel.icon!),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chatModel.name!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Online",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          PopupMenuButton(onSelected: (value) {
            print(value);
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: "View contact",
                child: Text('View contact'),
              ),
              const PopupMenuItem(
                value: "Media, links, and docs",
                child: Text('Media, links, and docs'),
              ),
              const PopupMenuItem(
                value: "Search",
                child: Text('Search'),
              ),
              const PopupMenuItem(
                value: "Mute notifications",
                child: Text('Mute notifications'),
              ),
              const PopupMenuItem(
                value: "Wallpaper",
                child: Text('Wallpaper'),
              ),
            ];
          })
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Stack(
            children: [
              ListView(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              focusNode: focusNode,
                              controller: _controller,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    focusNode.unfocus();
                                    focusNode.canRequestFocus = false;
                                    setState(() {
                                      showEmojiPicker = !showEmojiPicker;
                                    });
                                  },
                                  icon: const Icon(Icons.emoji_emotions),
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) =>
                                                bottomSheet());
                                      },
                                      icon: const Icon(Icons.attach_file),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.camera_alt),
                                    ),
                                  ],
                                ),
                                hintText: "Type a message",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            onPressed: () {},
                            child: const Icon(Icons.mic),
                          ),
                        ),
                      ],
                    ),
                    Offstage(
                      offstage: !showEmojiPicker,
                      child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            onEmojiSelected: (category, emoji) {
                              _controller.text = _controller.text + emoji.emoji;
                            },
                            onBackspacePressed: () {},
                            config: Config(
                              columns: 7,
                              // Issue: https://github.com/flutter/flutter/issues/28894
                              emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                              initCategory: Category.RECENT,
                              bgColor: const Color(0xFFF2F2F2),
                              indicatorColor: Colors.blue,
                              iconColor: Colors.grey,
                              iconColorSelected: Colors.blue,
                              backspaceColor: Colors.blue,
                              skinToneDialogBgColor: Colors.white,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              showRecentsTab: true,
                              recentsLimit: 28,
                              replaceEmojiOnLimitExceed: false,
                              noRecents: const Text(
                                'No Recents',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black26),
                                textAlign: TextAlign.center,
                              ),
                              loadingIndicator: const SizedBox.shrink(),
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: const CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL,
                              checkPlatformCompatibility: true,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
          onWillPop: () async {
            if (showEmojiPicker) {
              setState(() {
                showEmojiPicker = false;
              });
              return false;
            }
            return true;
          },
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
        height: 278,
        width: MediaQuery.of(context).size.width,
        child: Card(
            margin: const EdgeInsets.all(18.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconCreateion(
                        Icons.insert_drive_file,
                        "document",
                        Colors.indigo,
                      ),
                      iconCreateion(
                        Icons.camera_alt,
                        "Camera",
                        Colors.pink,
                      ),
                      iconCreateion(
                        Icons.insert_photo,
                        "Gallery",
                        Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconCreateion(
                        Icons.headset,
                        "Audio",
                        Colors.orange,
                      ),
                      iconCreateion(
                        Icons.location_pin,
                        "Location",
                        Colors.green,
                      ),
                      iconCreateion(
                        Icons.person,
                        "Contact",
                        Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget iconCreateion(IconData icon, String text, Color color) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
