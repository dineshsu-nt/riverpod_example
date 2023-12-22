import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:riverpod_example/state_notifier_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'api_screen.dart';
import 'hive_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'person_model.dart';

void main() async {
  await Supabase.initialize(
      url: "https://bxzneszwpypigmhjciyo.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ4em5lc3p3cHlwaWdtaGpjaXlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyOTQzMTIsImV4cCI6MjAxMzg3MDMxMn0.TGY_Qi2F-8puRju8CDZqTcDFcTMeZMSlIzA8dkGWkkI");
  await Hive.initFlutter();
  await Hive.openBox('hive_local_db');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SupabaseExample(),
    );
  }
}

//
// final counterStateProvider = StateProvider<int>((ref) {
//   return 10 * 1000;
// });
// final isRedProvider = Provider<bool>((ref) {
//   final color = ref.watch(selectedButtonProvider);
//   return color == "red";
// });
// final selectedButtonProvider = StateProvider<String>((ref) => "");
//
// class MyHomePage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var value = ref.watch(counterStateProvider);
//     var isRed = ref.watch(isRedProvider);
//     var selectedButton = ref.watch(selectedButtonProvider);
//     return Scaffold(
//       backgroundColor: isRed ? Colors.red : Colors.blue,
//       appBar: AppBar(title: const Text("RiverPod Example")),
//       body: Center(
//         child: Column(
//           children: [
//             Text(
//               "value: $value",
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             //TAP ON BUTTON TO INCREMENT VALUE OF THE COUNTER
//             ElevatedButton(
//                 onPressed: () {
//                   ref.read(counterStateProvider.notifier).state++;
//                 },
//                 child: const Text("Increment")),
//             //TAP ON BUTTON TO DECREMENT VALUE OF COUNTER
//             ElevatedButton(
//                 onPressed: () {
//                   ref.read(counterStateProvider.state).state--;
//                 },
//                 child: const Text("Decrement")),
//             //NAVIGATE TO API SCREEN
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ApiScreen()));
//                 },
//                 child: const Text("ApiScreen")),
//             //TAP TO CHANGE COLOR OF TEXT TO RED
//             ElevatedButton(
//                 onPressed: () {
//                   ref.read(selectedButtonProvider.notifier).state = "red";
//                 },
//                 child: const Text("red")),
//             //CHANGE THE COLOR OF TEXT TO BLUE
//             ElevatedButton(
//                 onPressed: () {
//                   ref.read(selectedButtonProvider.notifier).state = "blue";
//                 },
//                 child: const Text("blue")),
//             Text(
//               isRed ? "color is red" : "color is blue",
//               style: TextStyle(color: isRed ? Colors.red : Colors.blue),
//             ),
//             Text(selectedButton,
//                 style: TextStyle(color: isRed ? Colors.red : Colors.blue)),
//             //TAP TO NAVIGATE ON LIST SCREEN
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ListScreen()));
//                 },
//                 child: const Text("state notifier")),
//           ],
//         ),
//       ),
//     );
//   }
// }
class SupabaseExample extends StatefulWidget {
  const SupabaseExample({Key? key}) : super(key: key);

  @override
  State<SupabaseExample> createState() => _SupabaseExampleState();
}

class _SupabaseExampleState extends State<SupabaseExample> {
  final controller = TextEditingController();
  final supabase = Supabase.instance.client;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("supabase demo")),
      body: Column(
        children: [
          TextField(controller: controller),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await supabase.from('users').insert({
                  'user_name': controller.text,
                });
                controller.clear();
              },
              child: const Text("save")),
          ElevatedButton(
              onPressed: () async {
                await supabase.from('users').update({
                  'user_name': controller.text,
                }).match({"user_name": "denny str"});
                controller.clear();
              },
              child: const Text("update")),
          ElevatedButton(
              onPressed: () async {
                await supabase.from('users').delete().match({"id": "2"});
                controller.clear();
              },
              child: const Text("delete")),
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    final data = await supabase.from('users').select('user_name');
    if (data != null) {
      return data;
    }
    return data;
  }
}
