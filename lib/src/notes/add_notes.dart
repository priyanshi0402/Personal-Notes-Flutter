import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_notes/src/helper/notes_utils.dart';
import 'package:personal_notes/src/model/notes.dart';
import '../helper/hive/hive_keys.dart';
import '../helper/hive/hive_utils.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key, this.note});
  final Notes? note;

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();

  List<String> attachmentList = [];
  List<String> deletedAttachmentList = [];
  List<String> updatedAttachmentList = [];
  List<String> duplicateAttachmentList = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.note?.description ?? "";
    _titleController.text = widget.note?.title ?? "";
    if ((widget.note?.attachments ?? "").isNotEmpty) {
      setState(() {
        attachmentList = widget.note?.attachments.split(',') ?? [];
        duplicateAttachmentList = widget.note?.attachments.split(',') ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Notes'),
          actions: [_saveNotesButton()],
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      notesTitle(),
                      const SizedBox(height: 20),
                      notesDescripion(),
                      const SizedBox(height: 20),
                      if (attachmentList.isNotEmpty) ...[
                        imageGridView(),
                      ],
                      const SizedBox(height: 20),
                      addAttachmentButton(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget notesDescripion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: _descriptionController,
          maxLines: 6,
          maxLength: 300,
          decoration: const InputDecoration(
            hintText: 'Enter description',
            // border: InputBorder.none,
            // contentPadding: EdgeInsets.symmetric(vertical: 20.0),
          ),
          // maxLength: 50,
        )
      ],
    );
  }

  Widget notesTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Title',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: _titleController,
          // maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Enter Title',
            // border: InputBorder.none,
            // contentPadding: EdgeInsets.symmetric(vertical: 20.0),
          ),
          // maxLength: 50,
        )
      ],
    );
  }

  Widget imageGridView() {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        scrollDirection: Axis.horizontal,
        itemCount: attachmentList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final attachmentPath = attachmentList[index];
          return Container(
            padding: const EdgeInsets.only(top: 5),
            // color: Colors.amber,
            child: Stack(
              children: [
                getFilePreviewWidget(attachmentPath),
                Positioned(
                  top: 0,
                  right: -10,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        if (widget.note != null) {
                          deletedAttachmentList.add(attachmentList[index]);
                        }
                        duplicateAttachmentList.remove(attachmentList[index]);
                        updatedAttachmentList.remove(attachmentList[index]);
                        attachmentList.removeAt(index);
                      });
                      // Handle close button click
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getFilePreviewWidget(String file) {
    if (file.toLowerCase().contains("http:") ||
        file.toLowerCase().contains("https:")) {
      return Image.network(
        file,
        fit: BoxFit.cover,
        width: 100,
        height: 100,
      );
    } else {
      if (file.toLowerCase().endsWith('.jpg') ||
          file.toLowerCase().endsWith('.jpeg') ||
          file.toLowerCase().endsWith('.png')) {
        return Image.file(
          File(file),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        );
      } else {
        return Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.grey,
          ),
          child: getFileIconWidget(file),
        ); //Icon(Icons.picture_as_pdf);
      }
    }
  }

  Widget getFileIconWidget(String file) {
    if (file.endsWith('.pdf')) {
      return const Icon(Icons.picture_as_pdf);
    } else if (file.endsWith('.doc') || file.endsWith('.docx')) {
      return const Icon(Icons.description);
    } else if (file.endsWith('.mp3')) {
      return const Icon(Icons.audio_file);
    } else if (file.endsWith('.mp4')) {
      return const Icon(Icons.video_file);
    } else {
      return const Icon(Icons.insert_drive_file);
    }
  }

  Widget addAttachmentButton() {
    return MaterialButton(
      onPressed: _addAttachmentClicked,
      height: 50,
      minWidth: 200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // <-- Radius
      ),
      color: Colors.deepPurple,
      child: const Text(
        'Add Attachment',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _saveNotesButton() {
    return IconButton(
      onPressed: _saveNotesButtonClicked,
      icon: const Icon(Icons.save),
    );
  }

  void _addAttachmentClicked() {
    _openActionSheet();
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
                    },
                    child: const Text('Camera')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context, 'Photos');
                      _openPhotosImagePicker();
                    },
                    child: const Text('Photos')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context, 'Files');
                      _openFilePicker();
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

  void _openPhotosImagePicker() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        attachmentList.add(pickedImage.path);
        if (widget.note != null) {
          updatedAttachmentList.add(pickedImage.path);
        }
      }
    });
    print(pickedImage?.path ?? 'error ');
  }

  void _saveNotesButtonClicked() {
    if (_titleController.text.isEmpty) {
      _showAlertDialogue('Please enter Title');
    } else {
      setState(() {
        _loading = true;
      });
      final userID = HiveUtils.get(HiveKeys.userId).toString();
      if (widget.note == null) {
        if (attachmentList.isNotEmpty) {
          NotesHelper.uploadFiles(attachmentList, userID).then((urls) {
            // print(urls);
            final note = Notes(
                id: "id",
                userId: userID,
                title: _titleController.text,
                description: _descriptionController.text,
                attachments: urls.join(','),
                createdAt: DateTime.now().microsecondsSinceEpoch.toString());
            NotesHelper.addNotesInFireStore(note).then((value) {
              setState(() {
                _loading = false;
              });

              Navigator.pop(context);
            });
          });
        } else {
          final note = Notes(
              id: "id",
              userId: userID,
              title: _titleController.text,
              description: _descriptionController.text,
              attachments: "",
              createdAt: DateTime.now().microsecondsSinceEpoch.toString());
          NotesHelper.addNotesInFireStore(note).then((value) {
            setState(() {
              _loading = false;
            });
            Navigator.pop(context);
          });
        }
      } else {
        if (deletedAttachmentList.isNotEmpty) {
          NotesHelper.deleteAttachments(deletedAttachmentList);
        }
        String attachments = duplicateAttachmentList.isEmpty
            ? ""
            : duplicateAttachmentList.join(',');
        if (updatedAttachmentList.isEmpty) {
          final note = Notes(
              id: widget.note?.id ?? "",
              userId: userID,
              title: _titleController.text,
              description: _descriptionController.text,
              attachments: attachments,
              createdAt: widget.note?.createdAt ?? "");
          NotesHelper.updateNotesInFireStore(note).then((value) {
            setState(() {
              _loading = false;
            });
            Navigator.pop(context);
          });
        } else {
          NotesHelper.uploadFiles(updatedAttachmentList, userID).then((urls) {
            attachments = attachments.isEmpty
                ? "$attachments${urls.join(',')}"
                : "$attachments,${urls.join(',')}";
            // print(urls);
            final note = Notes(
                id: widget.note?.id ?? "",
                userId: userID,
                title: _titleController.text,
                description: _descriptionController.text,
                attachments: attachments,
                createdAt: widget.note?.createdAt ?? "");
            NotesHelper.updateNotesInFireStore(note).then((value) {
              setState(() {
                _loading = false;
              });
              Navigator.pop(context);
            });
          });
        }
      }
    }
  }

  void _showAlertDialogue(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Alert"),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
            ),
          ],
        );
      },
    );
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        attachmentList.add(result.files.single.path ?? "");
        if (widget.note != null) {
          updatedAttachmentList.add(result.files.single.path ?? "");
        }
      });

      print(result.files.single.path ?? "");
    } else {
      // User canceled the picker
    }
  }
}
