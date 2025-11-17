import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  double progress = 0.0;
  int currentTrackIndex = 0;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  bool isFavorite = false;
  bool enableNotifications = true;
  bool isShuffleEnabled = false;
  bool isLoading = false;

  final List<Map<String, String>> favorites = [
    {
      'title': 'Song A',
      'artist': 'Artist 1',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    },
    {
      'title': 'Another Sample',
      'artist': 'Test Artist 2',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    },
    {
      'title': 'Sample Track 3',
      'artist': 'Test Artist 3',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();

    // استماع لحالة التشغيل
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    // استماع لموضع التشغيل
    _audioPlayer.onPositionChanged.listen((Duration position) {
      if (mounted) {
        setState(() {
          currentPosition = position;
          if (totalDuration.inMilliseconds > 0) {
            progress = position.inMilliseconds / totalDuration.inMilliseconds;
          }
        });
      }
    });

    // استماع لمدة الأغنية
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          totalDuration = duration;
        });
      }
    });

    // استماع لنهاية التشغيل
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextTrack();
    });
  }

  Future<void> togglePlay() async {
    try {
      if (isPlaying) {
        await _audioPlayer.pause();
      } else {
        if (totalDuration == Duration.zero) {
          await playMusic(favorites[currentTrackIndex]['url']!);
        } else {
          await _audioPlayer.resume();
        }
      }
    } catch (e) {
      debugPrint('Error toggling play: $e');
      _showErrorMessage('خطأ في التشغيل');
    }
  }

  Future<void> playMusic(String url) async {
    try {
      setState(() {
        isLoading = true;
      });

      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error playing audio: $e');
      setState(() {
        isLoading = false;
      });
      _showErrorMessage('خطأ في تشغيل الموسيقى. تأكد من الاتصال بالإنترنت.');
    }
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red[700],
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> seekTo(double value) async {
    if (totalDuration.inMilliseconds > 0) {
      final position = Duration(
        milliseconds: (value * totalDuration.inMilliseconds).toInt(),
      );
      await _audioPlayer.seek(position);
    }
  }

  void playNextTrack() {
    setState(() {
      if (currentTrackIndex < favorites.length - 1) {
        currentTrackIndex++;
      } else {
        currentTrackIndex = 0;
      }
    });
    playMusic(favorites[currentTrackIndex]['url']!);
  }

  void playPreviousTrack() {
    setState(() {
      if (currentTrackIndex > 0) {
        currentTrackIndex--;
      } else {
        currentTrackIndex = favorites.length - 1;
      }
    });
    playMusic(favorites[currentTrackIndex]['url']!);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'تمت الإضافة إلى المفضلة' : 'تمت الإزالة من المفضلة',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void toggleShuffle() {
    setState(() {
      isShuffleEnabled = !isShuffleEnabled;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isShuffleEnabled
              ? 'تم تفعيل التشغيل العشوائي'
              : 'تم إيقاف التشغيل العشوائي',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void openQrScanner() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('ماسح QR'),
        content: const Text('ميزة مسح رمز QR قيد التطوير حالياً.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 35,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('القائمة')));
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
          ),
          title: const Text(
            'مشغل الموسيقى',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home, color: Colors.white)),
              Tab(icon: Icon(Icons.star, color: Colors.white)),
              Tab(icon: Icon(Icons.settings, color: Colors.white)),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: TabBarView(
            children: [
              _buildPlayerTab(),
              _buildFavoritesTab(),
              _buildSettingsTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.music_note,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              if (isLoading)
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            favorites[currentTrackIndex]['title'] ?? 'Track Title',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            favorites[currentTrackIndex]['artist'] ?? 'Artist Name',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(currentPosition),
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  _formatDuration(totalDuration),
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: progress.clamp(0.0, 1.0),
              onChanged: isLoading ? null : (value) => seekTo(value),
              activeColor: Colors.white,
              inactiveColor: Colors.white24,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: isLoading ? null : playPreviousTrack,
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: isLoading ? null : togglePlay,
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: const Color(0xFF1976D2),
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: isLoading ? null : playNextTrack,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                  size: 28,
                ),
                onPressed: toggleFavorite,
              ),
              IconButton(
                icon: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: openQrScanner,
              ),
              IconButton(
                icon: Icon(
                  Icons.shuffle,
                  color: isShuffleEnabled ? Colors.greenAccent : Colors.white,
                  size: 28,
                ),
                onPressed: toggleShuffle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, i) {
          final item = favorites[i];
          final isCurrentTrack = currentTrackIndex == i;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            color: isCurrentTrack
                ? Colors.white.withOpacity(0.2)
                : Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.music_note, color: Colors.white),
              ),
              title: Text(
                item['title'] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                item['artist'] ?? '',
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: IconButton(
                icon: Icon(
                  isCurrentTrack && isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  if (isCurrentTrack && isPlaying) {
                    _audioPlayer.pause();
                  } else {
                    setState(() {
                      currentTrackIndex = i;
                    });
                    playMusic(item['url']!);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Card(
            color: Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              value: enableNotifications,
              onChanged: (v) {
                setState(() {
                  enableNotifications = v;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      v ? 'تم تفعيل الإشعارات' : 'تم إيقاف الإشعارات',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              title: const Text(
                'تفعيل الإشعارات',
                style: TextStyle(color: Colors.white),
              ),
              activeColor: Colors.greenAccent,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.cloud, color: Colors.white),
              title: const Text(
                'المزامنة مع السحابة',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('جاري المزامنة...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'رجوع',
                style: TextStyle(
                  color: Color(0xFF1976D2),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
