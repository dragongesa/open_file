
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:open_file_android/open_file_android.dart';
import 'package:permission_handler/permission_handler.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _openResult = 'Unknown';

  Future<void> openFile() async {
    _openPickFile();
  }

  // ignore: unused_element
  _openPickFile() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    if (fileResult?.files.first != null) {
      Uint8List? fileBytes = fileResult!.files.first.bytes;

      final result =
      await OpenFileAndroid().open(fileResult.files.first.path);
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });
    }
  }


  // ignore: unused_element
  _openAppPrivateFile() async {
    //open an app private storage file
    final result = await OpenFileAndroid().open(
        "/data/data/com.crazecoder.openfileexample/cache/IMG20230610192318.jpg");
    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }

  // ignore: unused_element
  _openOtherAppFile() async {
    //open an external storage image file on android 13
    if (await Permission.manageExternalStorage.request().isGranted) {
      final result = await OpenFileAndroid().open("/data/user/0/xxx/images/1.jpg");
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });
    }
  }

  // ignore: unused_element
  _openExternalImage() async {
    //open an external storage image file on android 13
    // if (await Permission.photos.request().isGranted) {
    final result = await OpenFileAndroid().open("/sdcard/Download/R-C.jpg");
    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
    // }
  }

  // ignore: unused_element
  _openExternalVideo() async {
    //open an external storage video file on android 13
    if (await Permission.videos.request().isGranted) {
      final result = await OpenFileAndroid().open("/sdcard/Download/R-C.mp4");
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });
    }
  }

  // ignore: unused_element
  _openExternalAudio() async {
    //open an external storage audio file on android 13
    if (await Permission.audio.request().isGranted) {
      final result = await OpenFileAndroid().open("/sdcard/Download/R-C.mp3");
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });
    }
  }

  // ignore: unused_element
  _openExternalFile() async {
    //open an external storage file
    if (await Permission.manageExternalStorage.request().isGranted) {
      final result = await OpenFileAndroid().open("/sdcard/Android/data/R-C.xml");
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('open result: $_openResult\n'),
              TextButton(
                child: Text('Tap to open file'),
                onPressed: openFile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
