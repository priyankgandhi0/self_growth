import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class VoiceNoteController extends GetxController {
  bool isPlay = false;
  int firstTextIndex = 0;
  List _textList = [];

  List get textList => _textList;

  set textList(List value) {
    _textList = value;
    update();
  }

  String? audioPath;

  RecordState _recordStates = RecordState.stop;
  final scrollController = ScrollController();
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

  Future<void> startRecord() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        Directory cacheDirectory = await getApplicationCacheDirectory();
        _startTimer();
        await _audioRecorder.start(
            const RecordConfig(encoder: AudioEncoder.wav),
            path: "${cacheDirectory.path}/${Random().nextInt(1500)}.wav");
      }
    } catch (e) {
      // if (kDebugMode) {
      //   print("Recording Error is ------> $e");
      // }
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
    final String hours = _formatNumber(num.parse(minutes) ~/ 60);
    textList.add(
        '$minutes:${(int.parse(seconds)).toString().length == 1 ? '0${int.parse(seconds)}' : int.parse(seconds)}');
    print('_textList---${textList}');

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 700),
      curve: Curves.fastOutSlowIn,
    );
    update();
    return '$hours:$minutes:$seconds';
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

    _timer = Timer.periodic(const Duration(seconds: 1, milliseconds: 500),
        (Timer t) {
      recordDuration++;
      update();
    });
  }

  DateTime selectedDate = DateTime.now();
}
