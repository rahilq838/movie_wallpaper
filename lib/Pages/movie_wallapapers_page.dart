import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_wallpaper/Common/Widgets/set_bottom_wall_options.dart';
import 'package:movie_wallpaper/Models/movie_wallpaper.dart';
import '../Common/Widgets/custom_sliver_app_bar.dart';
import 'package:shimmer/shimmer.dart';
import '../Common/functions.dart';
import '../Common/theme_colors.dart';
import '../Models/movie.dart';
import '../Services/movie_wallpapers_service.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MovieWallpapersPage extends StatefulWidget {
  final Movie movie;

  const MovieWallpapersPage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieWallpapersPageState createState() => _MovieWallpapersPageState();
}

class _MovieWallpapersPageState extends State<MovieWallpapersPage> {
  MovieWallpapersService movieWallpapersService = MovieWallpapersService();
  late double height, width;

  onTapOfWall(MovieWallpaper movieWallpaper) async {
    showModalBottomSheet(
        context: context,
        builder: (_) => SetWallBottomOptions(
              movieWallpaper: movieWallpaper,
            ));

  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    Widget _buildImageWidget(MovieWallpaper? movieWallpaper) {
      return InkWell(
        onTap: () {
          movieWallpaper != null ? onTapOfWall(movieWallpaper) : null;
        },
        child: Padding(
          padding: getAllPadding(height),
          child: Container(
            decoration: getContainerBoxDecoration(),
            child: ClipRRect(
                borderRadius: getAllBorderRadius(),
                child: movieWallpaper != null
                    ? Image.network(
                        movieWallpaper.src,
                        fit: BoxFit.cover,
                      )
                    : Image.asset("assets/hp.jpg")),
          ),
        ),
      );
    }

    Widget gridBody() => StreamBuilder<List<MovieWallpaper>>(
        stream: movieWallpapersService.getMovieWall(widget.movie),
        builder: (context, snapshot) {
          // print(snapshot.data);
          return snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done
              ? SliverGrid.count(
                  crossAxisCount: 2,
                  children: snapshot.data!
                      .map((MovieWallpaper mw) => _buildImageWidget(mw))
                      .toList(),
                )
              : SliverGrid.count(
                  crossAxisCount: 2,
                  children: [
                    Shimmer.fromColors(
                        baseColor: foregroundClr,
                        highlightColor: backgroundClr,
                        child: _buildImageWidget(null)),
                    Shimmer.fromColors(
                        baseColor: foregroundClr,
                        highlightColor: backgroundClr,
                        child: _buildImageWidget(null)),
                  ],
                );
        });

    return Scaffold(
      backgroundColor: backgroundClr,
      body: CustomScrollView(
        slivers: [
          TopSliverAppBar(mHeight: height, text: widget.movie.name),
          gridBody()
        ],
      ),
    );
  }
}
