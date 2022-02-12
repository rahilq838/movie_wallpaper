import 'package:flutter/material.dart';
import 'package:movie_wallpaper/Common/functions.dart';
import 'package:movie_wallpaper/Common/theme_colors.dart';
import 'package:movie_wallpaper/Models/movie_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class SetWallBottomOptions extends StatefulWidget {
  final MovieWallpaper movieWallpaper;

  const SetWallBottomOptions({Key? key, required this.movieWallpaper})
      : super(key: key);

  @override
  _SetWallBottomOptionsState createState() => _SetWallBottomOptionsState();
}

class _SetWallBottomOptionsState extends State<SetWallBottomOptions> {
  late double height, width;



  Future onSetWall(int location) async{
    String url = widget.movieWallpaper.src;
    var file = await DefaultCacheManager().getSingleFile(url);
    return (await WallpaperManager.setWallpaperFromFile(file.path, location));
  }

  buildImage(MovieWallpaper movieWallpaper) => Padding(
      padding: getAllPadding(height),
      child: Container(
        decoration: getContainerBoxDecoration(),
        child: ClipRRect(
          borderRadius: getAllBorderRadius(),
          child: Image.network(
            movieWallpaper.src,
            fit: BoxFit.cover,
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return BottomSheet(
        backgroundColor: foregroundClr,
        onClosing: () {},
        builder: (_) => Column(
              children: [
                Expanded(child:buildImage(widget.movieWallpaper)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          onSetWall(WallpaperManager.HOME_SCREEN);
                        },
                        icon: const Icon(Icons.wallpaper_rounded,color: txtClr,),
                        label: Text(
                          "Home",
                          style: getNormalTxtStyle(),
                        )),
                    TextButton.icon(
                        onPressed: () {
                          onSetWall(WallpaperManager.LOCK_SCREEN);
                        },
                        icon: const Icon(Icons.wallpaper_rounded,color: txtClr,),
                        label: Text("LockScreen", style: getNormalTxtStyle()))
                  ],
                ),
              ],
            ));
  }
}
