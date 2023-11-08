import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';

class VoiceNoteController extends GetxController {
  bool isPlay = false;
  RecordState _recordStates = RecordState.stop;

  RecordState get recordStates => _recordStates;

  set recordStates(RecordState value) {
    _recordStates = value;
    update();
  }

  int _recordDuration = 0;

  int get recordDuration => _recordDuration;

  set recordDuration(int value) {
    _recordDuration = value;
    update();
  }

  StreamSubscription<RecordState>? _recordSub;
  final _audioRecorder = AudioRecorder();
  Timer? _timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      recordStates = recordState;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> stop({required void Function(String path) onStop}) async {
    _timer?.cancel();
    recordDuration = 0;

    final path = await _audioRecorder.stop();

    if (path != null) {
      onStop(path);
    }
    update();
  }

  Future<void> start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );

        print('${AudioEncoder.aacLc.name} supported: $isSupported');

        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();

        // start();
        recordDuration = 0;
        _startTimer();
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  String buildText() {
    if (recordStates != RecordState.stop) {
      return _buildTimer();
    }

    return "00:00:00";
  }

  String _buildTimer() {
    final String minutes = _formatNumber(recordDuration ~/ 60);
    final String seconds = _formatNumber(recordDuration % 60);

    return '$minutes : $seconds';
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      update();
    });
  }
}
