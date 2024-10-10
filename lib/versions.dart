import 'dart:io';

import 'package:args/args.dart';
import 'package:vnest/utils.dart';

void handleVersionsDisplaying(ArgResults command) {
  final appName = command['app'];
  final setupDirectory = Utils.getValidDirectory();

  if (setupDirectory == null) {
    print('No setup directory found.');
    return;
  }

  // Correctly form the app path
  final appPath = "${setupDirectory.path}/$appName";
  final appDirectory = Directory(appPath);

  // Debugging output to show the constructed path
  print('Checking app directory: $appPath');

  // Check if the app directory exists
  if (!appDirectory.existsSync()) {
    print('App does not exist.');
    return;
  }

  // List all version folders/files inside the app directory
  final List<FileSystemEntity> versionFiles = appDirectory.listSync();

  // Iterate and print each version directory
  final List<Directory> versionDirectories =
      Utils.getValidAppDirectories(appDirectory.path);
  // Check if any version directories exist
  if (versionDirectories.isEmpty) {
    print('No versions found for app: $appName.');
    print('To add a version, use the command: add $appName [version-number]');
    return;
  }
  print(appName);
  for (final version in versionDirectories) {
    print('|___ ${version.path.split('/').last}');
  }
}
