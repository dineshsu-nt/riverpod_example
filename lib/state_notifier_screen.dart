import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberProvider =
    StateNotifierProvider<NumberNotifier, List<String>>((ref) {
  return NumberNotifier();
});

class NumberNotifier extends StateNotifier<List<String>> {
  NumberNotifier()
      : super([
          "Number 12",
          "Number 90",
          "Number 67",
          "Number 23",
          "Number 41",
        ]);
}

class ListScreen extends ConsumerWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var number = ref.watch(numberProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: number.map((e) => Text(e)).toList(),
        ),
      ),
    );
  }
}
