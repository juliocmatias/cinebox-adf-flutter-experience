import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScream extends ConsumerStatefulWidget {
  const HomeScream({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreamState();
}

class _HomeScreamState extends ConsumerState<HomeScream> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
