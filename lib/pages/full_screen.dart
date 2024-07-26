import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imgUrl;

  const FullScreen({super.key, required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  bool _isLoading = false;
  String _resultMessage = '';

  Future<void> setWallpaper() async {
    setState(() {
      _isLoading = true;
      _resultMessage = '';
    });
    try {
      int location = WallpaperManager.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      setState(() {
        _resultMessage =
            result ? 'Wallpaper set successfully!' : 'Failed to set wallpaper.';
      });
    } catch (e) {
      setState(() {
        _resultMessage = 'Failed to set wallpaper: $e';
        print(e);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Image.network(widget.imgUrl),
            ),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              InkWell(
                onTap: () {
                  setWallpaper();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  height: 60,
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Set Background',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            if (_resultMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  _resultMessage,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
