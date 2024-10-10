import 'dart:io';

import 'package:args/args.dart';
import 'package:vnest/forms.dart';
import 'package:vnest/utils.dart';

void handleAdd(ArgResults command) {
  String? appName = command['app'];
  String? version = command['version'];

  // Print debug info
  print('App name: $appName');
  print('Version: $version');

  // Get the setup directory from config.txt
  String? setupDirectory = Utils.getSetupDirectory();

  if (setupDirectory == null) {
    print('No directory setup. Please run the setup command.');
    return; // Exit if the setup directory is not configured
  }

  final appDirectory = Directory(setupDirectory);

  // Check if the setup directory exists
  if (!appDirectory.existsSync()) {
    print('Setup directory does not exist. Please set up the directory first.');
    return;
  }

  if (appName != null && version != null) {
    // Create a version directory within the app's directory
    String versionDirectoryPath = '${appDirectory.path}/$appName/v$version';
    final versionDirectory = Directory(versionDirectoryPath);

    if (!versionDirectory.existsSync()) {
      versionDirectory.createSync(
          recursive: true); // Create the directory recursively
      print('Added app: $appName, version directory: $versionDirectoryPath');

      // Create metadata file for version
      _createMetadataFile(
          versionDirectoryPath, 'App: $appName, Version: $version');
      _createMetadataFile("${appDirectory.path}/$appName",
          'App: $appName,created on: ${DateTime.now()}');

      // Create subfolders (optional, based on your original logic)
      createVersionSubFolders(versionDirectoryPath);
      Forms.displayBuildInfoForm(versionDirectoryPath);
    } else {
      print('Version directory already exists: $versionDirectoryPath');
    }
  } else if (appName != null) {
    // Create an app directory in the setup directory
    String appDirectoryPath = '${appDirectory.path}/$appName';
    final appDir = Directory(appDirectoryPath);

    if (!appDir.existsSync()) {
      appDir.createSync(); // Create the app directory
      print('Added app: $appName, directory created: $appDirectoryPath');

      // Create metadata file for the app
      _createMetadataFile(
          appDirectoryPath, 'App: $appName,created on: ${DateTime.now()}');
    } else {
      print('App directory already exists: $appDirectoryPath');
    }
  } else {
    print('Please specify an app name to add.');
  }
}

// Helper function to create metadata file
void _createMetadataFile(String directoryPath, String content) {
  String metadataFilePath = '$directoryPath/.vnestmeta';
  final metadataFile = File(metadataFilePath);

  if (!metadataFile.existsSync()) {
    metadataFile
        .writeAsStringSync(content); // Write metadata content to the file
    print('Metadata file created at $metadataFilePath');
  } else {
    print('Metadata file already exists at $metadataFilePath');
  }
}

void createVersionSubFolders(String versionFolderPath) {
  final metaDataFolderPath = '$versionFolderPath/metadata';
  final sourceFolderPath = '$versionFolderPath/source';
  final dataFolderPath = '$versionFolderPath/data';
  final iosBuildFolderPath = '$versionFolderPath/ios_build';
  final androidBuildFolderPath = '$versionFolderPath/android_build';

  final metaDataDirectory = Directory(metaDataFolderPath).createSync();
  final sourceDirectory = Directory(sourceFolderPath).createSync();
  final dataDirectory = Directory(dataFolderPath).createSync();
  final iosBuildDirectory = Directory(iosBuildFolderPath).createSync();
  final androidBuildDirectory = Directory(androidBuildFolderPath).createSync();
}
