import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String path;
  const VideoView({Key? key, required this.path}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.crop_rotate),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.emoji_emotions_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.title),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 169,
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container()),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    color: Colors.black54,
                    child: TextFormField(
                      maxLines: 6,
                      minLines: 1,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                          size: 30,
                        ),
                        suffixIcon: CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        hintText: 'Add a caption...',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black38,
                    radius: 30,
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
