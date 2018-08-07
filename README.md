# flutter_firebase

A new Flutter project.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

## Firebase

Create a firebase project that has the database called `baby-names` with
documents in the following structure.

```yml
document key: Jeffrey
collection:
    name: Jeffrey
    votes: 0

document key: Terry
collection:
    name: Terry
    votes: 0
```

Go to the project settings and 'download the latest config file'; it should
be called `GoogleService-Info.plist`.

Place this file in your ios folder.

### Spin up an iOS simulator and run the code

```shell
open -a Simulator
flutter run
```

## VSCode debugging

You need to install the VSCode extensions for flutter.

Set a breakpoint somewhere in your code.

Then `CMD + SHIFT + P` and type `debug`. Look for `Attach to to a Dart process`
and paste `http://127.0.0.1:8100/` into the dialog.

Your debugging session should start.
