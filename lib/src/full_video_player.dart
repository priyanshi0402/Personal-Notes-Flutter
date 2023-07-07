// import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullVideoPlayer extends StatefulWidget {
  const FullVideoPlayer({super.key, this.videoUrl});

  final String? videoUrl;
  @override
  State<FullVideoPlayer> createState() => _FullVideoPlayerState();
}

class _FullVideoPlayerState extends State<FullVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl ?? ''))
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController.play();
          });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          videoPlayerView(),
          _progressBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _backwardbutton(),
              if (_videoPlayerController.value.isPlaying) ...[
                _playPausebutton(
                    iconData: Icons.pause,
                    onPressed: () {
                      setState(() {
                        _videoPlayerController.pause();
                      });
                    })
              ] else ...[
                _playPausebutton(
                    iconData: Icons.play_arrow,
                    onPressed: () {
                      setState(() {
                        _videoPlayerController.play();
                      });
                    })
              ],
              _forwardbutton()
            ],
          ),
        ],
      ),
    );
  }

  Widget videoPlayerView() {
    return _videoPlayerController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController))
        : Container(
            color: Colors.amber,
          );
  }

  Widget _playPausebutton({
    required IconData iconData,
    void Function()? onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(iconData),
    );
  }

  Widget _forwardbutton() {
    return IconButton(
        onPressed: () {
          _videoPlayerController.seekTo(Duration(
              seconds: _videoPlayerController.value.position.inSeconds + 10));
        },
        icon: const Icon(Icons.fast_forward));
  }

  Widget _backwardbutton() {
    return IconButton(
        onPressed: () {
          _videoPlayerController.seekTo(Duration(
              seconds: _videoPlayerController.value.position.inSeconds - 10));
        },
        icon: const Icon(Icons.fast_rewind));
  }

  Widget _progressBar() {
    return VideoProgressIndicator(
      _videoPlayerController,
      allowScrubbing: true,
      colors: const VideoProgressColors(
          playedColor: Colors.blue, backgroundColor: Colors.grey),
    );
  }
}
