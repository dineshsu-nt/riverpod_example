import 'package:flutter/material.dart';
import 'package:riverpod_example/person.model.dart';
import 'package:riverpod_example/test.dart';
import 'package:strava_client/strava_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final HiveMethods hiveMethods = HiveMethods();
  List<UserModel> users = [];
  bool isLoading = true;
  late final StravaClient stravaClient;
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    var usersData = await hiveMethods.getUserLists();
    if (usersData.isNotEmpty) {
      users.addAll(usersData);
    }
    setState(() {
      isLoading = false;
    });
  }

  void addUser() {
    hiveMethods.addUser(
      UserModel(
        id: 1,
        username: 'denny the great str',
        email: 'denny@gmail.com',
      ),
    );
  }

  void deleteAllUser() {
    hiveMethods.deleteAllUser();
  }

  void deleteUser(int index) {
    hiveMethods.deleteUser(index);
    setState(() {
      users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive DB'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    child: ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      backgroundColor: Colors.white,
                      childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                      title: Text(users[index].username),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteUser(index);
                        },
                      ),
                      children: [
                        Text('ID: ${users[index].id}'),
                        Text('Username: ${users[index].username}'),
                        Text('Email: ${users[index].email}')
                      ],
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser();
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ),
    );
  }
}
