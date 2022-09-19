import 'package:flutter/material.dart';
import 'package:mike/api/SoundPlayer.dart';
import 'package:mike/api/SoundRecorder.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final recorder = SoundRecorder();
  final player = SoundPlayer();

  @override
  void initState() {
    super.initState();

    recorder.init();
    player.init();
  }

  @override
  void dispose() {
    player.dispose();
    recorder.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Say on Mike"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildStart(),
            SizedBox(height: 40),
            buildPlay(),
          ],
        ),
      ),
    );
  }

  Widget buildStart() {
    final isRecording = recorder.isRecording;
    final recordIcon = isRecording ? Icons.stop : Icons.mic;
    final recordText = isRecording ? 'STOP' : 'START';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(175, 50),
        primary: primary,
        onPrimary: onPrimary,
      ),
      icon: Icon(recordIcon),
      label: Text(
        recordText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        final isRecording = await recorder.toggleRecording();
        setState(() {});
      },
    );
  }

  Widget buildPlay() {
    final isPlaying = player.isPlaying;
    final playIcon = isPlaying ? Icons.stop : Icons.play_arrow;
    final playText = isPlaying ? "Stop Playing" : "Play Recording";

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(175, 50),
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
      icon: Icon(playIcon),
      label: Text(
        playText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        await player.togglePlaying(whenFinished: () => setState(() {}));
        setState(() {});
      },
    );
  }
}
