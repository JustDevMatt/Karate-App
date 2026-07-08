import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'karate_data.dart';

class KataDetailScreen extends StatefulWidget {
  final Kata kata;

  const KataDetailScreen({super.key, required this.kata});

  @override
  State<KataDetailScreen> createState() => _KataDetailScreenState();
}

class _KataDetailScreenState extends State<KataDetailScreen> {
  YoutubePlayerController? _controller;
  double? _startSeconds;
  double? _endSeconds;
  Timer? _positionTimer;

  String? _extractVideoId(String url) {
    try {
      if (url.contains('shorts/')) {
        return url.split('shorts/').last.split('?').first.substring(0, 11);
      }
      RegExp regExp = RegExp(
        r'.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*',
        caseSensitive: false,
        multiLine: false,
      );
      final match = regExp.firstMatch(url);
      if (match != null && match.groupCount >= 1 && match.group(1)!.length == 11) {
        return match.group(1);
      }
    } catch (e) {
      print("Nie udało się odczytać linku: $url");
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    if (widget.kata.youtubeUrl != null) {
      String? videoId = _extractVideoId(widget.kata.youtubeUrl!);

      if (videoId != null) {
        _controller = YoutubePlayerController.fromVideoId(
          videoId: videoId,
          autoPlay: false,
          params: const YoutubePlayerParams(
            showControls: false,
            showFullscreenButton: true,
            mute: false,
            strictRelatedVideos: true,
          ),
        );

        _positionTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
          if (_controller != null && _endSeconds != null && _startSeconds != null) {
            double currentTime = await _controller!.currentTime;

            // Jeśli dotarliśmy do końca fragmentu, zapętl go
            if (currentTime >= _endSeconds!) {
              _controller!.seekTo(seconds: _startSeconds!, allowSeekAhead: true);
            }
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    _controller?.close();
    super.dispose();
  }

  // Uruchamia fragment
  void _playFragment(BuildContext context, double start, double? end) {
    if (_controller != null) {
      setState(() {
        _startSeconds = start;
        _endSeconds = end;
      });
      _controller!.seekTo(seconds: start, allowSeekAhead: true);
      _controller!.playVideo();
    }
  }

  // Nowa funkcja: Kasuje "pułapkę" czasową
  void _cancelLoop() {
    setState(() {
      _startSeconds = null;
      _endSeconds = null;
    });

    // Opcjonalny dymek informacyjny
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Zapętlanie wyłączone. Możesz obejrzeć wideo normalnie.'),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          widget.kata.name,
          style: GoogleFonts.oswald(
            textStyle: const TextStyle(color: Colors.amber, letterSpacing: 1.5),
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.amber),
      ),
      body: Column(
        children: [
          // 1. ODTWARZACZ WIDEO
          Container(
            width: double.infinity,
            color: Colors.black87,
            child: _controller != null
                ? YoutubePlayer(
              controller: _controller!,
              aspectRatio: 16 / 9,
            )
                : const SizedBox(
              height: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videocam_off, color: Colors.white24, size: 60),
                  SizedBox(height: 10),
                  Text('Brak wideo dla tego Kata', style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ),

          // 2. ROZPISKA RUCHÓW
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 80), // <--- TUTAJ ZMIEŃ PADDING!
              children: [
                const Text(
                  'ROZPISKA RUCHÓW (Kliknij, by odtworzyć fragment)',
                  style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 12),
                ),
                const SizedBox(height: 15),

                // ==========================================
                // NOWY PRZYCISK: Pojawia się tylko podczas pętli
                // ==========================================
                if (_startSeconds != null && _endSeconds != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _cancelLoop,
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text(
                          'WYŁĄCZ ZAPĘTLANIE FRAGMENTU',
                          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0)
                      ),
                    ),
                  ),

                if (widget.kata.startPosition != null)
                  _buildSpecialCommand('START', widget.kata.startPosition!),

                if (widget.kata.moves.isNotEmpty)
                  ...widget.kata.moves.asMap().entries.map((entry) {
                    int index = entry.key + 1;
                    KataMove move = entry.value;
                    bool hasVideoFragment = move.startSeconds != null;

                    // 2. NAPRAWA LOGIKI RAMKI
                    // Teraz sprawdzamy czy _startSeconds nie jest nullem ORAZ czy się zgadza
                    bool isCurrentlyPlaying = (_startSeconds != null && move.startSeconds != null && _startSeconds == move.startSeconds);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: (hasVideoFragment && _controller != null)
                            ? () => _playFragment(context, move.startSeconds!, move.endSeconds)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            // Podświetlamy ruch mocniej, jeśli właśnie leci w pętli
                            color: isCurrentlyPlaying
                                ? Colors.amber.withOpacity(0.15)
                                : (hasVideoFragment ? Colors.white.withOpacity(0.05) : Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                            border: isCurrentlyPlaying
                                ? Border.all(color: Colors.amber.withOpacity(0.5), width: 1)
                                : null,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: isCurrentlyPlaying
                                    ? Colors.amber
                                    : (hasVideoFragment ? Colors.amber.shade700 : Colors.amber.withOpacity(0.2)),
                                child: Text(
                                  '$index',
                                  style: TextStyle(
                                      color: (isCurrentlyPlaying || hasVideoFragment) ? Colors.black : Colors.amber,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  move.instruction,
                                  style: TextStyle(
                                      color: isCurrentlyPlaying
                                          ? Colors.amber
                                          : (hasVideoFragment ? Colors.amber.shade100 : Colors.white),
                                      height: 1.5,
                                      fontSize: 15
                                  ),
                                ),
                              ),
                              if (hasVideoFragment)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  // Jeśli pętla jest aktywna na tym fragmencie, pokaż kręcące się kółko, jeśli nie – ikonę Play
                                  child: isCurrentlyPlaying
                                      ? const Icon(Icons.loop, color: Colors.amber, size: 24)
                                      : const Icon(Icons.play_circle_outline, color: Colors.amber, size: 24),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                if (widget.kata.endPosition != null)
                  _buildSpecialCommand('KONIEC', widget.kata.endPosition!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialCommand(String label, String command) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.02),
          border: Border(left: BorderSide(color: Colors.grey.shade800, width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(command, style: const TextStyle(color: Colors.white54, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}