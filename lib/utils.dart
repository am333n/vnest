import 'dart:io';

class Utils {
  static String? getSetupDirectory() {
    final configFile =
        File('config.txt'); // This is where the setup directory is stored

    // Check if the config file exists
    if (configFile.existsSync()) {
      return configFile
          .readAsStringSync()
          .trim(); // Read and return the directory path
    } else {
      print(
          'Error: Setup directory not configured. Please run the "setup" command first.');
      return null;
    }
  }

  static Directory? getValidDirectory() {
    String? setupDirectory = getSetupDirectory();

    if (setupDirectory == null) {
      print('No directory setup. Please run the setup command.');
      return null; // Exit if the setup directory is not configured
    }

    final appDirectory = Directory(setupDirectory);

    // Check if the setup directory exists
    if (!appDirectory.existsSync()) {
      print(
          'Setup directory does not exist. Please set up the directory first.');
      return null;
    }
    return appDirectory;
  }

  static bool hasValidMetaData(String path) {
    String metaFilePath = '$path/.vnestmeta';
    final metaFile = File(metaFilePath);
    if (metaFile.existsSync()) {
      return true;
    }
    return false;
  }

  static List<Directory> getValidAppDirectories(String directoryPath) {
    final setupDirectory = Directory(directoryPath);

    // List all directories (apps) inside the setup directory
    List<FileSystemEntity> entities = setupDirectory.listSync();

    // Filter for valid app directories that contain the .vnestmeta file
    List<Directory> validAppDirectories = [];

    for (var entity in entities) {
      if (entity is Directory) {
        String metaFilePath = '${entity.path}/.vnestmeta';
        final metaFile = File(metaFilePath);

        if (metaFile.existsSync()) {
          validAppDirectories.add(entity);
        }
      }
    }

    return validAppDirectories;
  }
}
