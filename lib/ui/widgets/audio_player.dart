import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/utils/extentions.dart';

import '../../gen/assets.gen.dart';

class AudioPlayer extends StatefulWidget {
  /// Path from where to play recorded audio
  final String source;

  /// Callback when audio file should be removed
  /// Setting this to null hides the delete button
  final VoidCallback onDelete;

  const AudioPlayer({
    Key? key,
    required this.source,
    required this.onDelete,
  }) : super(key: key);

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  static const double _controlSize = 40;
  static const double _deleteBtnSize = 24;

  final _audioPlayer = ap.AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? _position;
  Duration? _duration;

  @override
  void initState() {
    _playerStateChangedSubscription =
        _audioPlayer.onPlayerComplete.listen((state) async {
      await stop();
      setState(() {});
    });
    _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
      (position) => setState(() {
        _position = position;
      }),
    );
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) => setState(() {
        _duration = duration;
      }),
    );

    super.initState();
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: <Widget>[
            _buildControl(),
            _buildSlider(constraints.maxWidth),
          ],
        );
      },
    );
  }

  Widget _buildControl() {
    // Icon icon;
    Color color;

    if (_audioPlayer.state == ap.PlayerState.playing) {
      // icon = Icon(Icons.pause, color: black_000000, size: 20.w);
      color = grey_C4C4C4;
    } else {
      // icon = Icon(Icons.play_arrow, color: black_000000, size: 20.w);
      color = grey_C4C4C4;
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(
              width: _controlSize,
              height: _controlSize,
              child: Assets.icons.player.svg()),
          onTap: () {
            if (_audioPlayer.state == ap.PlayerState.playing) {
              pause();
            } else {
              play();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSlider(double widgetWidth) {
    bool canSetValue = false;
    final duration = _duration;
    final position = _position;

    if (duration != null && position != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    double width = widgetWidth - _controlSize + _deleteBtnSize;
    width -= _deleteBtnSize;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.w,
            width: Get.width,
            child: SliderTheme(
              data: SliderThemeData(
                thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 6.r, elevation: 0.0),
              ),
              child: Slider(
                divisions: 24,
                activeColor: borderPurpleColor,
                thumbColor: borderPurpleColor,
                inactiveColor: Colors.transparent,
                onChanged: (v) {
                  if (duration != null) {
                    final position = v * duration.inMilliseconds;
                    _audioPlayer.seek(Duration(milliseconds: position.round()));
                  }
                },
                value: canSetValue && duration != null && position != null
                    ? position.inMilliseconds / duration.inMilliseconds
                    : 0.0,
              ),
            ),
          ),
          '0.01'
              .appSwitzerTextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  fontColor: doteColor)
              .paddingOnly(left: 20.w)
        ],
      ),
    );
  }

  Future<void> play() {
    return _audioPlayer.play(
      kIsWeb ? ap.UrlSource(widget.source) : ap.DeviceFileSource(widget.source),
    );
  }

  Future<void> pause() => _audioPlayer.pause();

  Future<void> stop() => _audioPlayer.stop();
}
