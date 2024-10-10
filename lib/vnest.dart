import 'dart:io';

import 'package:args/args.dart';
import 'package:vnest/versions.dart';

class CommandFunctions {
  // Handlers for each command
  void handleSetup(List<String> args) {
    String directory;

    if (args.isNotEmpty) {
      directory = args[0]; // Get the provided directory from the arguments
    } else {
      directory =
          Directory.current.path; // Use current directory if none provided
    }

    // Perform setup logic here
    print('Setting up SKU directory: $directory');

    // Save the directory to a config file
    saveDirectory(directory);
  }

// Function to save the directory path to a config file
  void saveDirectory(String directory) {
    final file = File('config.txt');
    file.writeAsStringSync(directory); // Write the directory to the file
    print('Directory saved to config: $directory');
  }

  String readDirectory() {
    final file = File('config.txt');
    if (file.existsSync()) {
      String directory = file.readAsStringSync();
      print('Loaded directory from config: $directory');
      return directory;
    } else {
      print('No configuration file found. Using current directory.');
      return Directory
          .current.path; // Default to current directory if file does not exist
    }
  }

  void handleApps(ArgResults command) {
    bool listApps = command['list'] as bool;
    if (listApps) {
      // Logic to list all apps
      print('Listing all stored apps...');
    }
  }

  void handleVersions(ArgResults command) {
    String? appName = command['app'];
    if (appName != null) {
      handleVersionsDisplaying(command);
    } else {
      print('Please specify an app using --app or -a.');
    }
  }

  void handleDelete(ArgResults command) {
    String? appName = command['app'];
    String? version = command['version'];

    if (appName != null) {
      if (version != null) {
        // Logic to delete the specified version
        print('Deleting version: $version from app: $appName...');
      } else {
        // Logic to delete the entire app
        print('Deleting entire app: $appName...');
      }
    } else {
      print('Please specify an app using --app or -a.');
    }
  }

  void handleBackup(ArgResults command) {
    String? appName = command['app'];
    if (appName != null) {
      // Logic to back up the app
      print('Backing up app: $appName...');
    } else {
      print('Please specify an app using --app or -a.');
    }
  }

  void handleMetadata(ArgResults command) {
    String? appName = command['app'];
    String? version = command['version'];

    if (appName != null) {
      if (version != null) {
        // Logic to get metadata for the specified app/version
        print('Fetching metadata for app: $appName, version: $version...');
      } else {
        print('Please specify a version using --version or -v.');
      }
    } else {
      print('Please specify an app using --app or -a.');
    }
  }

  void handleChangelog(ArgResults command) {
    String? appName = command['app'];
    String? version = command['version'];

    if (appName != null) {
      handleChangelog(command);
    } else {
      print('Please specify an app using --app or -a.');
    }
  }

  void handleSearch(ArgResults command) {
    String? keyword = command['keyword'];
    if (keyword != null) {
      // Logic to search for an app or version
      print('Searching for: $keyword...');
    } else {
      print('Please specify a keyword using --keyword or -k.');
    }
  }
}
