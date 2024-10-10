import 'package:vnest/add.dart';
import 'package:vnest/apps.dart';
import 'package:vnest/vnest.dart' as vnest;

import 'dart:io'; // Import for Directory and FileSystemEntity
import 'package:args/args.dart';

void main(List<String> arguments) {
  // Create an ArgParser instance
  final parser = ArgParser();
  final commandFunctions = vnest.CommandFunctions();

  // Define the main commands with respective options or flags
  parser.addCommand('setup', ArgParser());

  parser.addCommand('apps', ArgParser());

  parser.addCommand(
      'versions',
      ArgParser()
        ..addOption('app',
            abbr: 'a', help: 'List all versions for a specific app.'));

  parser.addCommand(
      'add',
      ArgParser()
        ..addOption('app',
            abbr: 'a', help: 'Add a new version of an app to the archive.')
        ..addOption('version',
            abbr: 'v', help: 'Specify the version number to add.'));

  parser.addCommand(
      'delete',
      ArgParser()
        ..addOption('app',
            abbr: 'a', help: 'Delete a specific version or even an entire app.')
        ..addOption('version',
            abbr: 'v', help: 'Specify the version number to delete.'));

  parser.addCommand(
      'backup',
      ArgParser()
        ..addOption('app',
            abbr: 'a', help: 'Backup the current version(s) of an app.'));

  parser.addCommand(
      'metadata',
      ArgParser()
        ..addOption('app',
            abbr: 'a',
            help:
                'Display build information and metadata for a specific version.')
        ..addOption('version',
            abbr: 'v', help: 'Specify the version number to get metadata.'));

  parser.addCommand(
      'changelog',
      ArgParser()
        ..addOption('app',
            abbr: 'a',
            help: 'Display the changelog for a specific app version.')
        ..addOption('version',
            abbr: 'v', help: 'Specify the version number to get changelog.'));

  parser.addCommand(
      'search',
      ArgParser()
        ..addOption('keyword',
            abbr: 'k', help: 'Search for an app or version in the nest.'));

  // Parse the arguments
  final argResults = parser.parse(arguments);

  // commandFunctions.Handle commands
  if (argResults.command == null) {
    print(
        'Please provide a command. Available commands: setup, apps, versions, add, delete, backup, metadata, changelog, search.');
    return;
  }

  switch (argResults.command!.name) {
    case 'setup':
      commandFunctions.handleSetup(argResults.command!.arguments);
      break;
    case 'apps':
      handleListApps();
      break;
    case 'versions':
      commandFunctions.handleVersions(argResults.command!);
      break;
    case 'add':
      handleAdd(argResults.command!);
      break;
    case 'delete':
      commandFunctions.handleDelete(argResults.command!);
      break;
    case 'backup':
      commandFunctions.handleBackup(argResults.command!);
      break;
    case 'metadata':
      commandFunctions.handleMetadata(argResults.command!);
      break;
    case 'changelog':
      commandFunctions.handleChangelog(argResults.command!);
      break;
    case 'search':
      commandFunctions.handleSearch(argResults.command!);
      break;
    default:
      print('Unknown command: ${argResults.command!.name}');
  }
}
