import 'dart:io';

class Forms {
  Future<bool> promptYesNo(String question) async {
    while (true) {
      // Display the question
      stdout.write('$question (y/n): ');
      // Read the input from the user
      String? response = stdin.readLineSync()?.trim().toLowerCase();

      // Check the response and return true or false
      if (response == 'y') {
        return true; // User responded with 'yes'
      } else if (response == 'n') {
        return false; // User responded with 'no'
      } else {
        print("Invalid input. Please enter 'y' for yes or 'n' for no.");
      }
    }
  }

  static Future<void> displayBuildInfoForm(String rootFolder) async {
    // Displaying prompt messages
    print("------------------------------------------------------------");
    print("Please enter the following build information:");
    print("------------------------------------------------------------");

    // Collecting user input
    String? appName = _promptUser("❓ Enter App Name: ");
    String? appVersion = _promptUser("❓ Enter Version: ");
    String? buildNumber = _promptUser("❓ Enter Build Number: ");
    String? buildMode = _promptUser("❓ Enter Build Mode (release/debug): ");
    String? minAndroidApi = _promptUser("❓ Enter Minimum Android API Level: ");
    String? minIosApi = _promptUser("❓ Enter Minimum iOS API Level: ");
    String? environment =
        _promptUser("❓ Enter Environment (Production/Development): ");
    String? branchName = _promptUser("❓ Enter Branch Name: ");
    String? flutterSdk = _promptUser(
        "❓ Enter Flutter SDK Version (leave empty to use the default): ");

    // Get the default Flutter SDK version if not provided
    if (flutterSdk == null || flutterSdk.isEmpty) {
      flutterSdk = await _getDefaultFlutterSdkVersion();
      print(
          "🟢 No Flutter SDK version entered, using default Flutter SDK version: $flutterSdk");
    }

    // Detect Android SDK version
    String androidSdk = await _detectAndroidSdkVersion();

    // Detect iOS SDK version
    String iosSdk = await _detectIosSdkVersion();

    // Get the current date
    String buildDate = DateTime.now().toIso8601String().split('T').first;

    // Create the build_info.txt inside the metadata folder
    String buildInfoFile = '$rootFolder/metadata/build_info.txt';
    _writeBuildInfo(
        buildInfoFile,
        appName,
        appVersion,
        buildNumber,
        buildMode,
        buildDate,
        minAndroidApi,
        minIosApi,
        androidSdk,
        iosSdk,
        environment,
        branchName,
        flutterSdk);

    // Create the CHANGELOG.md file in the metadata folder
    String changelogFile = '$rootFolder/metadata/CHANGELOG.md';
    _createChangelog(changelogFile);

    print("============================================================");
    print("✅ CHANGELOG.md file created in $changelogFile.");
    print(
        "+-------------------------------------------------------------------+");
    print(
        "|                                                                   |");
    print(
        "| Please fill out the CHANGELOG.md file located at $changelogFile. |");
    print(
        "|                                                                   |");
    print(
        "+-------------------------------------------------------------------+");
    print("============================================================");
  }

  // Prompt user for input
  static String? _promptUser(String message) {
    stdout.write(message);
    return stdin.readLineSync();
  }

  // Get default Flutter SDK version
  static Future<String> _getDefaultFlutterSdkVersion() async {
    // In a real application, you'd call a process to get the Flutter version
    // For now, let's simulate getting the version.
    return '3.0.0'; // Replace with actual Flutter SDK version retrieval logic
  }

  // Detect Android SDK version
  static Future<String> _detectAndroidSdkVersion() async {
    // Simulate detection logic, replace with actual implementation
    return 'Android SDK 30.0.3'; // Replace with sdkmanager command output
  }

  // Detect iOS SDK version
  static Future<String> _detectIosSdkVersion() async {
    // Simulate detection logic, replace with actual implementation
    return 'iOS SDK 14.5'; // Replace with xcodebuild command output
  }

  // Write build info to file
  static void _writeBuildInfo(
      String filePath,
      String? appName,
      String? appVersion,
      String? buildNumber,
      String? buildMode,
      String buildDate,
      String? minAndroidApi,
      String? minIosApi,
      String androidSdk,
      String iosSdk,
      String? environment,
      String? branchName,
      String? flutterSdk) {
    final String buildInfoContent = '''
App Name: $appName
Version: $appVersion
Build Number: $buildNumber
Build Mode: $buildMode
Build Date: $buildDate
Minimum Android API Level: $minAndroidApi
Minimum iOS API Level: $minIosApi
Android SDK: $androidSdk
iOS SDK: $iosSdk
Environment: $environment
Branch Name: $branchName
Flutter SDK: $flutterSdk
''';

    File(filePath).writeAsStringSync(buildInfoContent);
    print("Build info saved to $filePath");
  }

  // Create CHANGELOG.md file
  static void _createChangelog(String filePath) {
    const changelogContent = '''# Changelog

## [Unreleased]

### Added
-

### Changed
-

### Deprecated
-

### Removed
-

### Fixed
-

### Security
-

''';

    File(filePath).writeAsStringSync(changelogContent);
  }
}
