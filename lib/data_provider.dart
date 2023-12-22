import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/services.dart';

final userDataProvider = FutureProvider((ref) async{
  return ref.watch(userProvider).getUser();
});