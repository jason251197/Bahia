import 'package:appclientes/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AppCycle extends StatefulWidget {
  final Widget child;
  const AppCycle(this.child);

  @override
  _AppCycleState createState() => _AppCycleState();
}

class _AppCycleState extends State<AppCycle> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AuthExpire.refresh;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: widget.child);
  }
}
