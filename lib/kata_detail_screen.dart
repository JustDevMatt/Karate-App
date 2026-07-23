import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'karate_data.dart';

class KataDetailScreen extends StatefulWidget {
  final Kata kata;

  const KataDetailScreen({super.key, required this.kata});

  @override
  State<KataDetailScreen> createState() => _KataDetailScreenState();
}

class _KataDetailScreenState extends State<KataDetailScreen> {
  VideoPlayerController? _controller;
  final YoutubeExplode _yt = YoutubeExplode();

  bool _isLoading = true;
  bool _hasError = false;

  double? _startSeconds;
  double? _endSeconds;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  // MAGIA: Wyciągamy czysty plik MP4 z serwerów YouTube'a
  Future<void> _initVideo() async {
    try {
      if (widget.kata.youtubeUrl == null || widget.kata.youtubeUrl!.isEmpty) {
        throw Exception("Brak linku");
      }

      // 1. Pobieramy manifest wideo z YouTube
      var videoId = VideoId(widget.kata.youtubeUrl!);
      var manifest = await _yt.videos.streamsClient.getManifest(videoId);

      // 2. Wybieramy strumień wideo + audio o najwyższej jakości (często 720p)
      var streamInfo = manifest.muxed.withHighestBitrate();

      // 3. Ładujemy czysty plik do natywnego odtwarzacza
      _controller = VideoPlayerController.networkUrl(streamInfo.url);

      await _controller!.initialize();
      await _controller!.setLooping(true); // Główne zapętlenie całego układu
      await _controller!.play();

      // Zamiast Timera używamy natywnego nasłuchiwacza klatek (ultra precyzja)
      _controller!.addListener(_videoListener);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Błąd ładowania surowego wideo: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  // Ultra-precyzyjne zapętlanie fragmentów (bez migania ekranu!)
  void _videoListener() {
    if (_controller == null || _startSeconds == null || _endSeconds == null) return;

    // Zabezpieczenie przed błędem, gdy odtwarzacz nie jest gotowy
    if (!_controller!.value.isInitialized) return;

    final position = _controller!.value.position.inMilliseconds;
    final endMs = (_endSeconds! * 1000).toInt();
    final startMs = (_startSeconds! * 1000).toInt();

    // Jeśli przekroczyliśmy czas końcowy - błyskawiczny skok na początek
    if (position >= endMs) {
      _controller!.seekTo(Duration(milliseconds: startMs));
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    _yt.close(); // Zamknięcie ekstraktora YouTube
    super.dispose();
  }

  void _playFragment(BuildContext context, double start, double? end) {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      _startSeconds = start;
      _endSeconds = end;
    });

    _controller!.seekTo(Duration(milliseconds: (start * 1000).toInt()));
    _controller!.play();
  }

  void _cancelLoop() {
    setState(() {
      _startSeconds = null;
      _endSeconds = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Zapętlanie wyłączone. Możesz obejrzeć wideo normalnie.'),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _toggleSpeed() {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      double currentSpeed = _controller!.value.playbackSpeed;
      double newSpeed = currentSpeed == 1.0 ? 0.5 : 1.0;
      _controller!.setPlaybackSpeed(newSpeed);
    });
  }

  void _togglePlayPause() {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sprawdzamy na bieżąco status wideo, by ładnie renderować przyciski
    bool isPlaying = _controller?.value.isPlaying ?? false;
    double currentSpeed = _controller?.value.playbackSpeed ?? 1.0;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          widget.kata.name.toUpperCase(),
          style: GoogleFonts.oswald(
            textStyle: const TextStyle(color: Colors.amber, letterSpacing: 1.5),
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.amber),
      ),
      body: Column(
        children: [
          // 1. CZYSTY NATYWNY ODTWARZACZ WIDEO
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.black,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator(color: Colors.amber))
                      : _hasError
                      ? const Center(
                    child: Text(
                      'Błąd ładowania wideo.\nSprawdź połączenie z siecią.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                      : VideoPlayer(_controller!),
                ),
              ),

              // Niewidzialna tarcza łapiąca stuknięcia (pauza/start bezpośrednio przez kliknięcie w film)
              if (!_isLoading && !_hasError)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _togglePlayPause,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
            ],
          ),

          // 2. BEZPIECZNY PASEK KONTROLNY
          Container(
            color: const Color(0xFF1A1A1A),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: _toggleSpeed,
                  icon: const Icon(Icons.speed, color: Colors.amber, size: 20),
                  label: Text(
                    'TEMPO: ${currentSpeed}x',
                    style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.amber),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _togglePlayPause,
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.black),
                  label: Text(
                    isPlaying ? 'PAUZA' : 'START',
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Colors.white12, thickness: 1),

          // 3. ROZPISKA RUCHÓW (Oryginalna, niezmieniona logika)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
              children: [
                const Text(
                  'ROZPISKA RUCHÓW (Kliknij, by odtworzyć fragment)',
                  style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 12),
                ),
                const SizedBox(height: 15),

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

                    bool isCurrentlyPlaying = (_startSeconds != null && move.startSeconds != null && _startSeconds == move.startSeconds);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: hasVideoFragment
                            ? () => _playFragment(context, move.startSeconds!, move.endSeconds)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
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