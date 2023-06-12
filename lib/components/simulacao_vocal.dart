import 'dart:async';
import 'dart:io' show Platform;

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dart_numero_extenso_br/dart_converter_extenso_br.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/models/warning_model.dart';
import 'package:simulador_x/providers/app_provider.dart';
import 'package:simulador_x/screens/simulacao_loading_screen.dart';
import 'package:simulador_x/screens/simulacao_resultado_screen.dart';
import 'package:simulador_x/services/fetch_simulacao.dart';
import 'package:simulador_x/utils/speech_to_text_helper.dart';

enum TtsState { playing, stopped, paused, continued }

class SimulacaoVocal extends ConsumerStatefulWidget {
  final Function(int, int)? onPressed;

  const SimulacaoVocal({super.key, this.onPressed});

  @override
  ConsumerState<SimulacaoVocal> createState() => _SimulacaoVocalState();
}

class _SimulacaoVocalState extends ConsumerState<SimulacaoVocal> {
  late FlutterTts flutterTts;
  late SpeechToTextHelper _speechToText;

  int _valorDesejado = 0;
  int _prazo = 0;
  bool _interactionStarted = false;
  var _iconMic = const Icon(Icons.mic);
  bool _animate = false;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    _initTts();
  }

  initSpeechToText() async {
    _speechToText = SpeechToTextHelper();
    await _speechToText.initialize();
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
        // print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<void> _configTts() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setSpeechRate(isAndroid ? 0.5 : 1);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    try {
      await flutterTts.speak(text);
    } catch (e) {
      print(e);
    }
  }

  Future _stopSpeaking() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
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

  Future<int> _tryAnswer(
      String question, String confirm, dynamic parseValue) async {
    int answer = 0;
    String listenedWords = "";

    var tries = 3;

    do {
      if (tries < 3) {
        await _speak("Desculpe, não entendi. Poderia repetir?");
      }

      await _speak(question);
      listenedWords = await _speechToText.startListening();
      if (listenedWords.toLowerCase() == 'cancelar') {
        return -1;
      }

      final valor = parseValue(listenedWords);
      if (valor > 0) {
        answer = valor;
        await _speak(confirm.replaceAll("#", valor.toString()));
        break;

        // await _speak("Deseja continuar?");
        // var listenedWords = await _speechToText.startListening();
        // if (listenedWords.toLowerCase() == 'sim' ||
        //     listenedWords.toLowerCase() == 'ok') {
        //   break;
        // } else {
        //   return -1;
        // }
      }

      tries--;
    } while (tries > 0);

    return answer;
  }

  Future<bool> _voiceScript() async {
    try {
      await _speak("Olá, eu sou o Simulador X.");

      final valorDesejado = await _tryAnswer(
          "Qual valor deseja simular?",
          "Você disse # reais?",
          (String value) => ConverterExtenso.converter(value).toInt());
      if (valorDesejado <= 0) {
        if (valorDesejado == 0) {
          await _speak(
              "Desculpe, não consegui te entender. Tente novamente ou preencha o formulário.");
        }
        await _speak("Cancelando simulação.");
        resetState();
        return false;
      }

      final prazo = await _tryAnswer(
          "Muito bem, qual o prazo desejado em meses?",
          "Você disse # meses?",
          (String value) => validaPrazo(value));
      if (valorDesejado <= 0) {
        if (valorDesejado == 0) {
          await _speak("Desculpe, não consegui te entender.");
        }
        await _speak("Cancelando simulação.");
        resetState();
        return false;
      }

      await _speak("Ok, estou realizando a simulação.");

      ref
          .read(appProvider.notifier)
          .setSimulacao(valorDesejado.toDouble(), prazo);

      setState(() {
        _valorDesejado = valorDesejado;
        _prazo = prazo;
      });

      return true;
    } on Exception catch (e) {
      print(e);
      if (e == "O idioma do sistema deve ser Português (Brasil)") {
        await _speak("O idioma do sistema deve ser Português (Brasil)");
      } else
        await _speak("Houve um erro ao tentar te ouvir. Cancelando simulação.");
      resetState();
      return false;
    }
  }

  void resetState() {
    setState(() {
      _valorDesejado = 0;
      _prazo = 0;
      _animate = false;
      _iconMic = const Icon(Icons.mic);
    });
  }

  Future<void> finalizaImportacao(NavigatorState navigator) async {
    navigator.push(MaterialPageRoute(
        builder: (context) => SimulacaoLoadingScreen(
              vocal: true,
              vocalSpeak: _speak,
            )));

    setState(() {
      _interactionStarted = false;
      _iconMic = const Icon(Icons.mic);
      _animate = false;
    });
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
            // If interaction is started, stop listening
            await _stopSpeaking();

            await _speechToText.stopListening();

            setState(() {
              _interactionStarted = false;
              _iconMic = const Icon(Icons.mic_off);
              _animate = false;
            });
          } else {
            // else, start listening

            setState(() {
              _interactionStarted = true;
              _iconMic = const Icon(Icons.mic_off);
              _animate = true;
            });

            try {
              final hasDados = await _voiceScript();
              if (hasDados) {
                await finalizaImportacao(navigator);
              }
            } catch (error) {
              print(error);
              await _speak(
                  "Houve um erro ao tentar te ouvir. Cancelando simulação.");
              resetState();
            }
          }
        },
        tooltip: 'Listen',
        child: _iconMic,
      ),
    );
  }
}
