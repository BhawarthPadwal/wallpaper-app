import 'package:flutter/material.dart';
/*import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';*/

class FullScreen extends StatefulWidget {
  final String imgUrl;

  const FullScreen({super.key, required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  bool _isLoading = false;
  String _resultMessage = '';

  /*Future<void> setWallpaper() async {
    setState(() {
      _isLoading = true;
      _resultMessage = '';
    });

    try {
      int location = WallpaperManagerFlutter.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
      WallpaperManagerFlutter wallpaperManager = WallpaperManagerFlutter();
      await wallpaperManager.setwallpaperfromFile(file.path, location);
      setState(() {
        _resultMessage = 'Wallpaper set successfully!';
      });
    } catch (e) {
      setState(() {
        _resultMessage = 'Failed to set wallpaper: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.imgUrl),
              ),
            ),
            if (_isLoading)
              CircularProgressIndicator()
            else
              InkWell(
                onTap: () {},
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'Set Wallpaper',
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _resultMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
