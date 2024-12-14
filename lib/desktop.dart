import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(700, 566),
    minimumSize: Size(375, 566),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(
    windowOptions,
        () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );

  await windowManager.setSize(windowOptions.size!);
  await windowManager.setMinimumSize(windowOptions.minimumSize!);
}
