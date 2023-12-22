import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/data_provider.dart';
import 'package:riverpod_example/user_model.dart';

class ApiScreen extends ConsumerWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(userDataProvider);
    debugPrint("build+==============================");
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Data"),
      ),
      body: data.when(
        data: (data) {
          List<User> userList = data.map((e) => e).toList();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        debugPrint(index.toString());
                      },
                      child: Card(
                        color: Colors.blue,
                        child: ListTile(
                          subtitle: Text(
                            userList[index].title,
                            style: const TextStyle(color: Colors.red),
                          ),
                          title: Text(userList[index].id.toString()),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
