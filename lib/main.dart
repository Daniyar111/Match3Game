import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/app.dart';
import 'src/utils/audio.dart';

void main() async {

  // Initialize the audio
  await Audio.init();

  // Remove the status bar
  SystemChrome.setEnabledSystemUIOverlays([]);

  return runApp(App());
}