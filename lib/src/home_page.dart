import 'package:flutter/material.dart';
import 'package:personal_notes/src/chat_user.dart';
import 'package:personal_notes/src/signup_page.dart';
import 'package:personal_notes/src/users_list.dart';

import 'notes/my_notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          _profileButton(),
          _chatButton(),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                text: 'Notes',
              ),
              Tab(
                text: 'Users',
              ),
            ],
            labelColor: Colors.deepPurple,
            labelStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            indicatorColor: Colors.deepPurple,
            unselectedLabelColor: Colors.deepPurple.shade200,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const <Widget>[
                Center(
                  child: DisplayNotes(),
                ),
                Center(
                  child: UsersListWidget(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _profileButton() {
    return IconButton(
        onPressed: _navigateToProfile, icon: const Icon(Icons.person));
  }

  Widget _chatButton() {
    return IconButton(onPressed: _navigateToChat, icon: const Icon(Icons.chat));
  }

  void _navigateToProfile() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const SignUpPage(isMyProfile: true);
      },
    ));
  }

  void _navigateToChat() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const ChatUserWidget();
      },
    ));
  }
}
