import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dart_numero_extenso_br/dart_converter_extenso_br.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simulador_x/providers/app_provider.dart';
import 'package:simulador_x/screens/simulacao_loading_screen.dart';
import 'package:simulador_x/utils/speech_to_text_helper.dart';
import 'package:simulador_x/utils/tts_helper.dart';

enum TtsState { playing, stopped, paused, continued }

class SimulacaoVocal extends ConsumerStatefulWidget {
  final Function(int, int)? onPressed;

  const SimulacaoVocal({super.key, this.onPressed});

  @override
  ConsumerState<SimulacaoVocal> createState() => _SimulacaoVocalState();
}

class _SimulacaoVocalState extends ConsumerState<SimulacaoVocal> {
  late TtsHelper tts = TtsHelper();
  late SpeechToTextHelper _speechToText;

  bool _interactionStarted = false;
  var _iconMic = const Icon(Icons.mic);
  bool _animate = false;
  bool errorInitSpeechToText = false;

  @override
  void initState() {
    super.initState();
    initServices();
  }

  initServices() async {
    _speechToText = SpeechToTextHelper();
    try {
      await tts.initTts();
      await _speechToText.initialize();
    } catch (error) {
      setState(() {
        errorInitSpeechToText = true;
      });
    }
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
        await tts.speak("Desculpe, não entendi. Poderia repetir?");
      }

      await tts.speak(question);
      listenedWords = await _speechToText.startListening();
      if (listenedWords.toLowerCase() == 'cancelar') {
        return -1;
      }

      final valor = parseValue(listenedWords);
      if (valor > 0) {
        answer = valor;
        await tts.speak(confirm.replaceAll("#", valor.toString()));
        break;

        // TODO: implementar confirmação
        // await tts.speak("Deseja continuar?");
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
      await tts.speak("Olá, eu sou o Simulador X.");

      final valorDesejado = await _tryAnswer(
          "Qual valor deseja simular?",
          "Você disse # reais?",
          (String value) => ConverterExtenso.converter(value).toInt());
      if (valorDesejado <= 0) {
        if (valorDesejado == 0) {
          await tts.speak(
              "Desculpe, não consegui te entender. Tente novamente ou preencha o formulário.");
        }
        await tts.speak("Cancelando simulação.");
        resetState();
        return false;
      }

      final prazo = await _tryAnswer(
          "Muito bem, qual o prazo desejado em meses?",
          "Você disse # meses?",
          (String value) => validaPrazo(value));
      if (valorDesejado <= 0) {
        if (valorDesejado == 0) {
          await tts.speak("Desculpe, não consegui te entender.");
        }
        await tts.speak("Cancelando simulação.");
        resetState();
        return false;
      }

      await tts.speak("Ok, estou realizando a simulação.");

      ref
          .read(appProvider.notifier)
          .setSimulacao(valorDesejado.toDouble(), prazo);

      return true;
    } on Exception catch (e) {
      print(e);
      if (e.toString() == "O idioma do sistema deve ser Português (Brasil)") {
        await tts.speak("O idioma do sistema deve ser Português (Brasil)");
      } else {
        await tts
            .speak("Houve um erro ao tentar te ouvir. Cancelando simulação.");
      }
      resetState();
      return false;
    }
  }

  void resetState() {
    setState(() {
      _animate = false;
      _iconMic = const Icon(Icons.mic);
    });
  }

  Future<void> finalizaImportacao(NavigatorState navigator) async {
    navigator.push(MaterialPageRoute(
        builder: (context) => SimulacaoLoadingScreen(
              vocal: true,
              vocalSpeak: tts.speak,
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
    // if (errorInitSpeechToText) {
    //   return Container();
    // }
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
          if (errorInitSpeechToText) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: const Text("Alerta"),
                  content: const Text("Ocorreu um erro ao iniciar o microfone."
                      "\nVerifique as permissões do aplicativo."
                      "\nE seu sistema está em Português (Brasil)."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          resetState();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok")),
                  ]),
            );
            return;
          }
          if (_interactionStarted) {
            // If interaction is started, stop listening
            await tts.stopSpeaking();

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
              await tts.speak(
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
