# Flutter boilerplate

## Getting Started

-[Get the Flutter SDK](https://flutter.dev/docs/development/tools/sdk/releases). Please chose a version suitable with your Operation System

- Remember to add Flutter exe path into the Environments of your System
  `export PATH="$PATH:`pwd`/flutter/bin"`
- Optionally, pre-download development binaries:
- Run `flutter precache` to pre-download binaries files needed
  For additional download options, see flutter help pre-cache.

- Run `flutter doctor` to check if everything that you are setting up are correct. The result may be something like this:

```
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/obiwan/Library/Android/sdk
    ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
    • Try re-installing or updating your Android SDK,
      visit https://flutter.dev/setup/#android-setup for detailed instructions.
```

- Should use the specific version of Flutter, CocoaPods:

```
1. Flutter: `v1.17.1`, you can use the `flutter version` command
  flutter version v1.17.1
2. CocoaPods: `1.7.5`, install by terminal: 
  sudo gem install cocoapods -v 1.7.5
```

## Create and run a simple Flutter app

1. Create a new Flutter app by running the following from the command line:

```
 flutter create my_app
```

2. A my_app directory is created, containing Flutter’s starter app. Enter this directory:

```
 cd my_app
```

3. To launch the app in the Simulator, ensure that the Simulator is running and enter:

```
 flutter run
```

## Set up an editor

- IntelliJ IDEA is ***Recommend to use*** with plugin `flutter-i18n`.
- Visual Studio Code
- You can use Android Studio, version 3.0

  After that install Flutter and Dart Plugins for your editor

## Folder structure

The following is the core folder structure which Flutter provides

```
new_life_flutter/
|- android
|- assets
|- build
|- ios
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- constants/
|- models/
|- providers/
|- pages/
|- services/
|- utils/
|- components/
|- main.dart
|- routes.dart


```

Dive into the lib folder has the main code for the application

```
1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`,`color`, `dimentions`, `images`,`text_styles` and `strings`.
2- models - Contains the models layer of the project.
3- providers - Contains the set of class that provide data for the application, it absolutely manages the data flow.
4- pages — Contains all the ui of your project, contains sub directory for each screen.
5- services - Contains the data layer of your project, includes directories for local, network and shared pref/cache.
6- utils — Contains the utilities/common functions of the application.
7- components — Contains the common widgets for the applications. For example, Button, TextField etc.
8- routes.dart — This file contains all the routes for the application.
9- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

## Exciting feature

```
- State management: Provider 3.1.0
- Http handler: Dio library
- Multilanguage: I18n follow [this article](https://dev.to/pedromassango/how-to-i18n-in-flutter-46km)
- Dart linter
- Integrate CI/CD progress
- Error reporting management: For more info consider reading this full [example](https://gist.github.com/slightfoot/094657bb22e986bbb4c9bafd9841cbd8) by Simon Lightfoot
- Flutter Util: Library for adapting screen and font size
- Re configure Shared Preference to use any time synchronous
```

## Error reporting management

## State Management

[Simple app state management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)


## Style guide

- You need to use Dart analysis in IDE or problems tab in VS Code and resole all the warning before pull request
- Following the [link](https://dart-lang.github.io/linter/lints/) to catch up the whole configuration
- [Style guide from Flutter team](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo#introduction)
- [Effective Dart from Dart team](https://dart.dev/guides/language/effective-dart)


## Parsing json to model

There are two ways to solve that:
1. Use `json_serializable` package officially from Dart with command to generate model, it also spreads by Flutter team
- Follow this [link](https://flutter.dev/docs/development/data-and-backend/json)
- By running flutter pub run build_runner build in the project root
2. Use easier way by a few website like [this](https://javiercbk.github.io/json_to_dart) or [another](https://app.quicktype.io/)


## Multilanguage
- Update new word in assets/langs/`languageCode`
- Use this synctax to get content: Translations.text('home_page'),
- If need to use argument: Translations.text('page_number', args: {'pageNumber': '1'})
- Change language: 
```
Translations.load(Locale(newLanguageCode));
```

## Simple helps

This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [A library of free to download Flutter templates](https://startflutter.com)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Contribution guidelines

1. Create branch with folder name and Jira ticket,depend on what kind of task, might create: feature/FBL-148 or hotfix/FBL-149,etc,..
2. Push the branch to remote and pull request to develop branch
3. Considering the comments, rebase and push again
4. Merge branch or wait to be merged into master
