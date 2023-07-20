import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/service/add_donor_service.dart';
import 'package:project1/view/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyNavigationObserver extends NavigatorObserver {
  final WidgetRef ref;
  MyNavigationObserver({required this.ref});
  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute?.settings.name == '/') {
      ref.read(donorData.notifier).state = null;
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print('pushed');
    super.didPush(route, previousRoute);
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [MyNavigationObserver(ref: ref)],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
