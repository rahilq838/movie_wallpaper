import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_wallpaper/Common/Widgets/custom_sliver_app_bar.dart';
import 'package:movie_wallpaper/Common/Widgets/sliver_body.dart';
import 'package:movie_wallpaper/Common/theme_colors.dart';
import 'package:movie_wallpaper/Models/movie.dart';
import 'package:movie_wallpaper/Pages/movie_wallapapers_page.dart';
import 'package:shimmer/shimmer.dart';
import '../Common/functions.dart';
import '../Services/movie_wallpapers_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double height, width;
  MovieWallpapersService movieWallpapers = MovieWallpapersService();

  void onTapOfMovie(Movie movie) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MovieWallpapersPage(movie: movie)));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    Widget body() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: StreamBuilder<List<Movie>>(
                    stream: movieWallpapers.getAllMovies(),
                    builder: (context, snapshot) {
                      return snapshot.hasData &&
                              snapshot.connectionState == ConnectionState.done
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (_, index) => InkWell(
                                    onTap: () => onTapOfMovie(snapshot.data![index]),
                                    child: Card(
                                      color: foregroundClr,
                                      elevation: 3,
                                      // decoration: getContainerBoxDecoration(),
                                      child: ListTile(
                                        title: Text(snapshot.data![index].name,
                                            style: getNormalTxtStyle()),
                                      ),
                                    ),
                                  ))
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              shrinkWrap: true,
                              itemBuilder: (_, index) => Shimmer.fromColors(
                                    baseColor: foregroundClr,
                                    highlightColor: backgroundClr,
                                    child: Card(
                                      color: foregroundClr,
                                      elevation: 3,
                                      // decoration: getContainerBoxDecoration(),
                                      child: ListTile(
                                        title: Text('$index',
                                            style: getNormalTxtStyle()),
                                      ),
                                    ),
                                  ));
                    }))
          ],
        );

    return Scaffold(
      backgroundColor: backgroundClr,
      body: CustomScrollView(
        slivers: [
          TopSliverAppBar(mHeight: height, text: 'Home'),
          CustomScrollViewBody(bodyWidget: body())
        ],
      ),
    );
  }
}
