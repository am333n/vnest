import 'dart:io';

import 'package:vnest/utils.dart';

void handleListApps() {
  final setupDirectory = Utils.getValidDirectory();
  if (setupDirectory == null) {
    return;
  }

  // Get valid app directories
  List<Directory> validAppDirectories =
      Utils.getValidAppDirectories(setupDirectory.path);

  // Check if there are any valid apps
  if (validAppDirectories.isEmpty) {
    print('No apps found in the version nest.');
    print('To add an app, use the command: add [app-name]');
  } else {
    print('List of apps:');
    for (var appDirectory in validAppDirectories) {
      print("|_____ ${appDirectory.path.split('/').last}"); // e.g., app_myApp
    }
  }
}
