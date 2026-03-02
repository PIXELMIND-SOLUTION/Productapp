import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBackControl extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTabChange;
  final int homeIndex;

  const AppBackControl({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTabChange,
    this.homeIndex = 0,
  });

  Future<bool> _onWillPop(BuildContext context) async {
    // If not on home tab → go to home tab
    if (currentIndex != homeIndex) {
      onTabChange(homeIndex);
      return false;
    }

    // If already on home tab → show exit dialog
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Do you want to close the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );

    if (shouldExit == true) {
      SystemNavigator.pop(); // Close app
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: child,
    );
  }
}