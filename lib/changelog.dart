import 'dart:io';

import 'package:args/args.dart';
import 'package:vnest/utils.dart';

void handleChangelogDisplaying(ArgResults command) {
  final appName = command['app'];
  final version = command['version'];
  final setupDirectory = Utils.getValidDirectory();

  if (setupDirectory == null) {
    print('No setup directory found.');
    return;
  }

  // Validate app name
  if (appName != null) {
    // Get valid app directories
    final appDirectories = Utils.getValidAppDirectories(setupDirectory.path);

    // Find the specified app directory
    final appDirectory = appDirectories.firstWhere(
      (app) => app.path.split('/').last == appName,
    );

    if (appDirectory == null) {
      print('App $appName not found.');
      return;
    }

    // If a version is provided, display that specific changelog
    if (version != null) {
      final versionDirectoryPath = '${appDirectory.path}/$version';
      final changelogFilePath = '$versionDirectoryPath/CHANGELOG.md';

      if (File(changelogFilePath).existsSync()) {
        print('Changelog for version $version of app $appName:');
        print(File(changelogFilePath).readAsStringSync());
      } else {
        print('No changelog found for version $version of app $appName.');
      }
    } else {
      // If no version is specified, list all versions and their changelogs
      final versionDirectories =
          Utils.getValidAppDirectories(appDirectory.path);

      if (versionDirectories.isEmpty) {
        print('No versions found for app $appName.');
        return;
      }

      print('Versions and changelogs for app $appName:');
      for (var versionDir in versionDirectories) {
        final changelogFilePath = '${versionDir.path}/CHANGELOG.md';
        String versionNumber =
            versionDir.path.split('/').last; // Extract version number

        if (File(changelogFilePath).existsSync()) {
          print('Version: $versionNumber');
          print('Changelog:');
          print(File(changelogFilePath).readAsStringSync());
          print('-----------------------------');
        } else {
          print('No changelog found for version: $versionNumber');
        }
      }
    }
  } else {
    print('Please specify an app name.');
  }
}
