import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_notes/src/notes/add_notes.dart';
// import 'package:personal_notes/src/rxDart/get_notes.dart';
import '../helper/hive/hive_keys.dart';
import '../helper/hive/hive_utils.dart';
import '../model/notes.dart';
import '../provider/notes/bloc/notes_bloc.dart';

class DisplayNotes extends StatefulWidget {
  const DisplayNotes({super.key, this.userId});
  final String? userId;
  @override
  State<DisplayNotes> createState() => _DisplayNotesState();
}

class _DisplayNotesState extends State<DisplayNotes> {
  final NotesBloc notesBloc = NotesBloc();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final id = widget.userId ?? HiveUtils.get(HiveKeys.userId).toString();
    notesBloc.add(NotesEvent.getPost(id));
    // _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => notesBloc,
      child: Scaffold(
        appBar: (widget.userId ?? "").isEmpty
            ? null
            : AppBar(
                title: const Text('Notes'),
              ),
        body: _buildBody(), //_loading
        //     ? const Center(child: CircularProgressIndicator.adaptive())
        //     : ,
        floatingActionButton: addNotesButton(),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      color: Colors.deepPurple,
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // <-- Radius
                ),
                leading: const Icon(Icons.search),
                tileColor: Colors.white,
                title: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                  onChanged: searchNotes,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    _searchController.clear();
                    searchNotes('');
                  },
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  notesBloc.add(const NotesEvent.sortPost());
                  // setState(() {
                  //   userNotes.sort((a, b) =>
                  //       a.title.toLowerCase().compareTo(b.title.toLowerCase()));
                  // });
                },
                icon: const Icon(
                  Icons.sort_by_alpha,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _searchBar(),
        _streamBuilder(),
      ],
    );
  }

  Widget _streamBuilder() {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return state.when(initial: () {
          return const SizedBox.shrink();
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }, success: (notes) {
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return _listItem(index: index, note: notes[index]);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 5,
                thickness: 1,
              );
            },
          );
        });
      },
    );
    // return StreamBuilder<List<Notes>>(
    //   stream: notesBloc.notesObservable,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       final userNotes = snapshot.data ?? [];
    //       return ListView.separated(
    //         shrinkWrap: true,
    //         padding: const EdgeInsets.all(15),
    //         itemCount: userNotes.length,
    //         itemBuilder: (context, index) {
    //           return _listItem(index: index, note: userNotes[index]);
    //         },
    //         separatorBuilder: (context, index) {
    //           return const Divider(
    //             height: 5,
    //             thickness: 1,
    //           );
    //         },
    //       );
    //     } else {
    //       return const Center(
    //         child: CircularProgressIndicator.adaptive(),
    //       );
    //     }
    // if (snapshot.hasData) {
    //   userNotes = snapshot.data ?? [];
    //   return ListView.separated(
    //     shrinkWrap: true,
    //     padding: const EdgeInsets.all(15),
    //     itemCount: userNotes.length,
    //     itemBuilder: (context, index) {
    //       return _listItem(index: index);
    //     },
    //     separatorBuilder: (context, index) {
    //       return const Divider(
    //         height: 5,
    //         thickness: 1,
    //       );
    //     },
    //   );
    // } else {
    //   return const Center(
    //     child: CircularProgressIndicator.adaptive(),
    //   );
    // }
    //   },
    // );
  }

  // Widget _listView() {
  //   return ListView.separated(
  //     shrinkWrap: true,
  //     padding: const EdgeInsets.all(15),
  //     itemCount: userNotes.length,
  //     itemBuilder: (context, index) {
  //       return _listItem(index: index);
  //     },
  //     separatorBuilder: (context, index) {
  //       return const Divider(
  //         height: 15,
  //         thickness: 1,
  //       );
  //     },
  //   );
  // }

  Widget _listItem({required int index, required Notes note}) {
    // final note = userNotes[index];
    return Row(
      children: [
        Expanded(
          // flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              Text(
                note.description,
                maxLines: 2,
                style: const TextStyle(fontSize: 15),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Column(
          children: [
            if ((widget.userId ?? "").isEmpty) ...{
              popUpMenuButton(index: index, note: note)
            },
            if (note.attachments.isNotEmpty) ...[
              const Icon(Icons.attachment_outlined)
            ] else
              const SizedBox(
                height: 25,
              )
          ],
        ),
      ],
    );
  }

  Widget popUpMenuButton({required int index, required Notes note}) {
    // final note = userNotes[index];
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'edit') {
          _editNotes(note);
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'delete',
            onTap: () {
              notesBloc.add(NotesEvent.deletePost(note));
              // notesBloc.deleteNote(note: note);
            },
            child: const Text('Delete'),
          ),
          const PopupMenuItem(
            value: 'edit',
            child: Text('Edit'),
          ),
        ];
      },
    );
  }

  Widget addNotesButton() {
    return (widget.userId ?? "").isEmpty
        ? FloatingActionButton(
            onPressed: _navigateToAddNotes,
            child: const Icon(Icons.add),
          )
        : Container();
  }

  void _navigateToAddNotes() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const AddNotes();
      },
    )).then((value) {
      final id = widget.userId ?? HiveUtils.get(HiveKeys.userId).toString();
      // notesBloc.getNotes(userID: id);
      notesBloc.add(NotesEvent.getPost(id));
      // _refreshNotes();
    });
  }

  void _editNotes(Notes note) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return AddNotes(note: note);
      },
    )).then((value) {
      final id = widget.userId ?? HiveUtils.get(HiveKeys.userId).toString();
      notesBloc.add(NotesEvent.getPost(id));
    });
  }

  void searchNotes(String value) {
    notesBloc.add(NotesEvent.searchPost(value));
  }

  void _refreshNotes() {
    // final id = widget.userId ?? HiveUtils.get(HiveKeys.userId).toString();
    // NotesHelper.getAllNotesFuture(id).then((notes) {
    //   setState(() {
    //     _loading = false;
    //     userNotes = notes;
    //     filteredNotes = notes;
    //   });
    // });
  }
}
