import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:personal_notes/src/full_video_player.dart';
import 'package:personal_notes/src/helper/chat_utils.dart';
import 'package:personal_notes/src/model/messages.dart';
import 'helper/helper_class.dart';
import 'helper/hive/hive_keys.dart';
import 'helper/hive/hive_utils.dart';
import 'model/users.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.user});
  final Users? user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatId = "";
  final int _limit = 20;
  // int _limitIncrement = 20;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final toId = widget.user?.id ?? "";
    final fromId = HiveUtils.get(HiveKeys.userId).toString();

    if (fromId.compareTo(toId) > 0) {
      chatId = '$fromId-$toId';
    } else {
      chatId = '$toId-$fromId';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user?.name ?? "")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildListMessage(),
            ),
            buildInput(),
          ],
        ),
      ),
    );
  }

  // Widget buildLoading() {
  //   return Positioned(
  //     child: isLoading ? LoadingView() : SizedBox.shrink(),
  //   );
  // }

  Widget _buildListMessage() {
    return Container(
        child: chatId.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              )
            : StreamBuilder<List<MessagesChat>>(
                stream: ChatHelper.getChatMessages(chatId, _limit),
                builder: (context, AsyncSnapshot<List<MessagesChat>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      // return const Center(
                      //     child: Text("No message here yet..."));
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return buildItem(snapshot.data![index]);
                        },
                        reverse: true,
                      );
                    } else {
                      return const Center(
                          child: Text("No message here yet..."));
                    }
                  } else {
                    return const Center(child: Text("No message here yet..."));
                  }
                },
              ));
  }

  Widget buildItem(MessagesChat message) {
    final currentUserId = HiveUtils.get(HiveKeys.userId).toString();
    if (message.idFrom == currentUserId) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              if (message.type == TypeMessage.text) ...[
                Container(
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('#6554AF'),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  margin: const EdgeInsets.only(right: 10, bottom: 2),
                  width: 200,
                  child: Text(
                    message.content,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ] else if (message.type == TypeMessage.image) ...[
                _imagePreview(message: message)
              ] else if (message.type == TypeMessage.video) ...[
                _imagePreview(message: message, isVideo: true)
              ] else ...[
                filePreview(message)
              ],
              Container(
                padding: const EdgeInsets.only(left: 90),
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  DateFormat('dd MMM kk:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(message.timeStamp))),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  widget.user?.profileImage ?? "",
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  },
                ),
              ),
              if (message.type == TypeMessage.text) ...[
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 200,
                  decoration: BoxDecoration(
                      color: HexColor.fromHex('#2B2730'),
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.only(left: 10, bottom: 2),
                  child: Text(
                    message.content,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ] else if (message.type == TypeMessage.image) ...[
                _imagePreview(message: message)
              ] else if (message.type == TypeMessage.video) ...[
                _imagePreview(message: message, isVideo: true)
              ] else ...[
                filePreview(message)
              ],
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10, left: 45),
            child: Text(
              DateFormat('dd MMM kk:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(message.timeStamp))),
              textAlign: TextAlign.end,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      );
    }
  }

  Widget _imagePreview({required MessagesChat message, bool isVideo = false}) {
    final currentUserId = HiveUtils.get(HiveKeys.userId).toString();
    if (message.idFrom == currentUserId) {
      return Container(
        // padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 2, right: 10),
        decoration: BoxDecoration(
          color: HexColor.fromHex('#6554AF'),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: imageChildWidget(message: message, isVideo: isVideo),
      );
    } else {
      return Container(
        // padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 2, left: 10),
        decoration: BoxDecoration(
          color: HexColor.fromHex('#6554AF'),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: imageChildWidget(message: message, isVideo: isVideo),
      );
    }
  }

  Widget imageChildWidget(
      {required MessagesChat message, required bool isVideo}) {
    return TextButton(
      onPressed: () {},
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        child: isVideo
            ? setImage(message)
            : Image.network(
                message.content,
                width: 150,
                height: 200,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget setImage(MessagesChat chat) {
    return Stack(
      children: [
        Image.network(
          chat.videothumbnail,
          width: 150,
          height: 200,
          fit: BoxFit.cover,
        ),
        Positioned(
          width: 150,
          height: 200,
          child: IconButton.filled(
            iconSize: 50,
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullVideoPlayer(
                      videoUrl: chat.content,
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }

  Widget filePreview(MessagesChat message) {
    final currentUserId = HiveUtils.get(HiveKeys.userId).toString();
    if (message.idFrom == currentUserId) {
      // Container(
      //             decoration: BoxDecoration(
      //               color: HexColor.fromHex('#6554AF'),
      //               borderRadius: BorderRadius.circular(10),
      //             ),
      //             padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      //             margin: const EdgeInsets.only(right: 10, bottom: 2),
      //             width: 180,
      //             child: Text(
      //               message.content,
      //               style: const TextStyle(color: Colors.white),
      //             ),
      //           )
      return Container(
        // padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        width: 180,
        // height: 50,
        margin: const EdgeInsets.only(bottom: 2, right: 10),
        decoration: BoxDecoration(
          color: HexColor.fromHex('#6554AF'),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: childFileWidget(message),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 2, left: 10),
        decoration: BoxDecoration(
          color: HexColor.fromHex('#6554AF'),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: childFileWidget(message),
      );
    }
  }

  Widget childFileWidget(MessagesChat message) {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: [
          const Icon(
            size: 30,
            Icons.file_download_outlined,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              message.filename,
              style: const TextStyle(
                  color: Colors.white, backgroundColor: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
          color: Colors.white),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            child: IconButton(
              icon: const Icon(Icons.image),
              onPressed: () {
                _openActionSheet();
              },
              color: Colors.deepPurple,
            ),
          ),
          Flexible(
              child: TextField(
            onSubmitted: (value) {
              onSendMessage(
                  content: textEditingController.text, type: TypeMessage.text);
            },
            style: const TextStyle(fontSize: 15),
            controller: textEditingController,
            decoration: const InputDecoration.collapsed(
              hintText: 'Type your message...',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            autofocus: true,
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                onSendMessage(
                    content: textEditingController.text,
                    type: TypeMessage.text);
              },
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  void onSendMessage(
      {required String content,
      required int type,
      String filename = "",
      String thumbnail = ""}) {
    if (content.trim().isNotEmpty) {
      final toId = widget.user?.id ?? "";
      final fromId = HiveUtils.get(HiveKeys.userId).toString();
      textEditingController.clear();
      ChatHelper.sendMessage(content, type, chatId, fromId, toId, filename,
          thumbnail: thumbnail);
      // if (listScrollController.hasClients) {
      //   listScrollController.animateTo(0,
      //       duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      // }
    } else {
      // Fluttertoast.showToast(
      //     msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    }
  }

  void _openActionSheet() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              title: const Text('Choose Image'),
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context, 'Camera');
                      getImage(ImageSource.camera);
                    },
                    child: const Text('Camera')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context, 'Photos');
                      getImage(ImageSource.gallery);
                    },
                    child: const Text('Photos')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context, 'Videos');
                      getVideo();
                    },
                    child: const Text('Videos')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context, 'Files');
                      _getFiles();
                    },
                    child: const Text('Files')),
              ],
              cancelButton: CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Cancel')),
            ));
  }

  Future getImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: source).catchError((err) {
      print(err);
      // Fluttertoast.showToast(msg: err.toString());
      return null;
    });

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      uploadFile(type: TypeMessage.image, file: imageFile);
    }
  }

  void _getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path ?? "");
      uploadFile(type: TypeMessage.file, file: file).then((value) {});
      // setState(() {
      //   attachmentList.add(result.files.single.path ?? "");
      //   if (widget.note != null) {
      //     updatedAttachmentList.add(result.files.single.path ?? "");
      //   }
      // });

      print(result.files.single.path ?? "");
    } else {
      // User canceled the picker
    }
  }

  Future getVideo() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickVideo(source: ImageSource.gallery)
        .catchError((err) {
      print(err);
      // Fluttertoast.showToast(msg: err.toString());
      return null;
    });

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      getVideoThumbnail(pickedFile.path).then((value) {
        uploadFile(type: TypeMessage.video, file: imageFile, videoFile: value)
            .then((value) {});
      });
    }
  }

  Future<String> getVideoThumbnail(String video) async {
    final file = await VideoThumbnail.thumbnailFile(
        video: video, imageFormat: ImageFormat.JPEG);
    print(file);
    return file ?? "";
  }

  Future uploadFile(
      {required int type, required File file, String videoFile = ""}) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
    ChatHelper.uploadFile(file: file, chatId: chatId).then((value) {
      if (videoFile.isNotEmpty) {
        ChatHelper.uploadFile(file: File(videoFile), chatId: chatId)
            .then((thumbnail) {
          onSendMessage(content: value, type: type, thumbnail: thumbnail);
        }).onError((error, stackTrace) {
          onSendMessage(content: value, type: type, filename: file.name);
        });
      } else {
        onSendMessage(content: value, type: type, filename: file.name);
      }
      Navigator.pop(context);
    });
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
