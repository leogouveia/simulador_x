import 'dart:async';
import 'dart:io';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum TtsState { playing, stopped, paused, continued }

class SpeechToTextHelper {
  SpeechToText speechToText = SpeechToText();
  Completer<String> completer = Completer<String>();
  bool hasSpeech = false;
  bool _speechEnabled = false;
  final _listenForSecs = 5;
  String _status = '';

  final void Function(dynamic error)? onError;
  final void Function(String status)? onStatus;

  static void _defaultOnError(dynamic error) {
    print("Error: $error");
  }

  static void _defaultOnStatus(String status) {
    print("Status: $status");
  }

  SpeechToTextHelper(
      {this.onError = _defaultOnError, this.onStatus = _defaultOnStatus});

  Future<void> initialize() async {
    final hasSpeech = await speechToText.initialize(
      onError: _onError,
      onStatus: _onStatus,
    );

    if (!hasSpeech) {
      throw Exception('Erro ao inicializar o SpeechToText');
    }

    _speechEnabled = true;
    var systemLocale = await speechToText.systemLocale();
    var locales = await speechToText.locales();
    var currentLocaleId = systemLocale?.localeId ?? '';
    var currentLocaleName = systemLocale?.name ?? '';
    if (currentLocaleId.toLowerCase() != "pt_br") {
      completer
          .completeError("O idioma do sistema deve ser Português (Brasil)");
    }
  }

  void _onError(dynamic error) async {
    print(error);
    if (error.errorMsg == 'error_no_match') {
      await speechToText.cancel();
      return completer.complete("");
    }
    if (completer.isCompleted) {
      return;
    }
    completer.completeError(error);
    onError!(error);
  }

  void _onStatus(String status) {
    print(status);
    _status = status;
    if (!completer.isCompleted && status == 'done') {
      // completer.complete("");
    }
    onStatus!(status);
  }

  void _onResult(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    if (result.recognizedWords.length > 3) {
      if (!completer.isCompleted) {
        completer.complete(result.recognizedWords);
      }
    } else if (result.finalResult) {
      if (!completer.isCompleted) {
        completer.complete(result.recognizedWords);
        completer.complete("");
      }
    }
  }

  Future<String> startListening() async {
    completer = Completer<String>();

    if (speechToText.isListening) {
      speechToText.stop();
    }

    // Se o usuário não iniciou o speechToText manualmente, então inicia
    if (!_speechEnabled) {
      await initialize().catchError((error) {
        completer.completeError(error);
      });
    }

    try {
      await speechToText.listen(
        listenFor: Duration(seconds: _listenForSecs),
        // onDevice: Platform.isAndroid ? true : false,
        localeId: "pt_BR",
        partialResults: false,
        onResult: _onResult,
      );
    } catch (e) {
      speechToText.cancel();
      completer.completeError(e);
    }

    return completer.future;
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future stopListening() async {
    await speechToText?.stop();
  }

  String get status {
    return _status;
  }
}
