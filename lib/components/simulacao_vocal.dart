import 'dart:async';
import 'dart:io' show Platform;

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dart_numero_extenso_br/dart_converter_extenso_br.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/models/warning_model.dart';
import 'package:simulador_x/screens/simulacao_resultado_screen.dart';
import 'package:simulador_x/services/fetch_simulacao.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum TtsState { playing, stopped, paused, continued }

class SimulacaoVocal extends StatefulWidget {
  final Function(int, int)? onPressed;

  const SimulacaoVocal({super.key, this.onPressed});

  @override
  State<SimulacaoVocal> createState() => _SimulacaoVocalState();
}

class _SimulacaoVocalState extends State<SimulacaoVocal> {
  late FlutterTts flutterTts;
  late SpeechToText _speechToText;

  int _valorDesejado = 0;
  int _prazo = 0;
  bool _interactionStarted = false;
  bool _hasSimulacao = false;

  var _iconMic = const Icon(Icons.mic_off);
  bool _animate = false;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  get isPaused => ttsState == TtsState.paused;

  get isContinued => ttsState == TtsState.continued;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initTts();
  }

  // TTS
  void _initTts() async {
    flutterTts = FlutterTts();
    _configTts();

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<void> _configTts() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  Future _stopSpeaking() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  // Speech to text
  void _initSpeech() async {
    _speechToText = SpeechToText();
    await _speechToText.initialize();
    setState(() {});
  }

  Future<String> _startListening() async {
    var completer = Completer<String>();

    try {
      await _speechToText.listen(
        onResult: (SpeechRecognitionResult result) async {
          try {
            if (result.recognizedWords.length > 3) {
              if (!completer.isCompleted) {
                completer.complete(result.recognizedWords);
                _speechToText.stop();
              }
              _speechToText.stop();
            } else if (result.finalResult) {
              if (!completer.isCompleted) {
                completer.complete(result.recognizedWords);
              }
              _speechToText.stop();
              await Future.delayed(const Duration(seconds: 10));
              completer.complete("");
            }
          } catch (e) {
            print(e);
            _speechToText.cancel();
            completer.completeError(e);
          }
        },
      );
    } catch (e) {
      _speechToText.cancel();
      completer.completeError(e);
    }

    return completer.future;
  }

  int? validaPrazo(String prazo) {
    var prazoNumber = ConverterExtenso.converter(
        prazo.replaceAll(RegExp(r'mes(es)?'), '').trim());

    if (prazoNumber > 0 && prazoNumber <= 240) {
      return prazoNumber.truncate().toInt();
    }

    var numeroSoDigitos = prazo.replaceAll(RegExp(r'[/D]'), '');
    var numeroSoDigitosDouble = double.tryParse(numeroSoDigitos);

    if (numeroSoDigitosDouble != null &&
        numeroSoDigitosDouble > 0 &&
        numeroSoDigitosDouble < 120) {
      return numeroSoDigitosDouble.truncate().toInt();
    }

    return null;
  }

  Future<bool> _voiceScript() async {
    await _speak("Olá, eu sou seu Simulador.");
    var listenedWords = "";

    await _speak("Qual valor gostaria de simular?");

    listenedWords = await _startListening().catchError((e) {
      print(e.message);
      return e.message;
    });

    final valorDesejado = ConverterExtenso.converter(listenedWords).toInt();

    if (valorDesejado == 0) {
      await _speak("Desculpe, não entendi.");
      return false;
    }

    await _speak("Você disse $valorDesejado reais.");

    await _speak("Muito bem, qual o prazo desejado em meses?");
    listenedWords = await _startListening();

    var prazo = validaPrazo(listenedWords);
    if (prazo == null) {
      await _speak("Desculpe, não entendi.");
      return false;
    }

    await _speak("Você disse $prazo meses?");
    await _speak("Ok, estou realizando a simulação.");

    setState(() {
      _valorDesejado = valorDesejado;
      _prazo = prazo;
      _hasSimulacao = true;
    });

    return true;
  }

  void resetState() {
    setState(() {
      _hasSimulacao = false;
      _valorDesejado = 0;
      _prazo = 0;
      _animate = false;
      _iconMic = const Icon(Icons.mic);
    });
  }

  Future<void> finalizaImportacao(NavigatorState navigator) async {
    SimulacaoDados? dadosSimulacao;
    Warning? warning;
    final valorDesejado = _valorDesejado.toDouble();
    final prazo = _prazo;
    (await FetchSimulacao.getSimulacao(valorDesejado, prazo)).fold(
        (dadosSimulacaoResult) {
      dadosSimulacao = dadosSimulacaoResult;
    }, (warningResult) {
      warning = warningResult;
    });

    setState(() {
      _interactionStarted = false;
      _iconMic = const Icon(Icons.mic);
      _animate = false;
    });

    if (dadosSimulacao != null) {
      navigator.push(
        MaterialPageRoute(
          builder: (context) => SimulacaoResultScreen(
            valor: valorDesejado,
            prazo: prazo,
            simulacaoDados: dadosSimulacao,
          ),
        ),
      );
      resetState();
      await _speak(
          'Simulação realizada com sucesso. Veja o resultado na tela.');
    } else {
      String mensagem = 'Houve um problema na simulação.';
      if (warning != null && warning!.mensagem != "") {
        mensagem = warning!.mensagem;
      }
      _showWarning(mensagem);
      await _speak('Houve um problema na simulação. Tente novamente.');
    }
  }

  Future<void> _showWarning(String warningText) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(warningText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return AvatarGlow(
      glowColor: Theme.of(context).colorScheme.secondary,
      endRadius: 50.0,
      duration: const Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: const Duration(milliseconds: 100),
      animate: _animate,
      child: FloatingActionButton(
        onPressed: () async {
          if (_interactionStarted) {
            await _stopSpeaking();
            await _speechToText.stop();
            setState(() {
              _interactionStarted = false;
              _iconMic = const Icon(Icons.mic_off);
              _animate = false;
            });
          } else {
            setState(() {
              _interactionStarted = true;
              _iconMic = const Icon(Icons.mic);
              _animate = true;
            });

            final hasDados = await _voiceScript();
            if (hasDados) {
              await finalizaImportacao(navigator);
            }
          }
        },
        tooltip: 'Listen',
        child: _iconMic,
      ),
    );
  }
}
