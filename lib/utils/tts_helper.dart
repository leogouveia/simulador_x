import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class TtsHelper {
  late FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  // TTS
  Future initTts() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setSpeechRate(isAndroid ? 0.5 : 1);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    flutterTts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      ttsState = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      ttsState = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      ttsState = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      // print("error: $msg");
      ttsState = TtsState.stopped;
    });
  }

  Future<void> speak(String text) async {
    try {
      await flutterTts.speak(text);
    } catch (e) {
      print(e);
    }
  }

  Future stopSpeaking() async {
    var result = await flutterTts.stop();
    if (result == 1) ttsState = TtsState.stopped;
  }
}
