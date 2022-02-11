
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_wallpaper/Common/Widgets/custom_sliver_app_bar.dart';
import 'package:movie_wallpaper/Common/theme_colors.dart';

import '../Common/functions.dart';
import '../Services/movie_wallpapers.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {
  late double height,width;
  MovieWallpapersService movieWallpapers = MovieWallpapersService();
  List<Widget> images = [];




  GridView _buildContent(List<Widget> images) {
    return GridView.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return images[index];
      },
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      padding: getAllPadding(height),
    );
  }

  @override
  void initState() {
    images = [
    //   _buildImageWidget('assets/hp.jpg'),
    //   _buildImageWidget('assets/hp.jpg'),
    //   _buildImageWidget('assets/hp.jpg'),
    //   _buildImageWidget('assets/hp.jpg'),
    //   _buildImageWidget('assets/hp.jpg'),
    //   _buildImageWidget('assets/hp.jpg'),
    //   _buildImageWidget('assets/hp.jpg'),
    //   _buildImageWidget('assets/hp.jpg'),
    //   _buildImageWidget('assets/hp.jpg')
    ];
    super.initState();
    movieWallpapers.getAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    Widget _buildImageWidget(String imagePath) {
      return Padding(
        padding: getAllPadding(height),
        child: Container(
          decoration: getContainerBoxDecoration(),
          child: ClipRRect(
            borderRadius: getAllBorderRadius(),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundClr,
      body: CustomScrollView(
        slivers: [
          TopSliverAppBar(mHeight: height, text: 'Home'),
          SliverGrid.count(crossAxisCount: 2,children: [
            _buildImageWidget('assets/hp.jpg'),
            _buildImageWidget('assets/hp.jpg'),
            _buildImageWidget('assets/hp.jpg'),
            _buildImageWidget('assets/hp.jpg'),
            _buildImageWidget('assets/hp.jpg'),
          ],)
        ],
      ),
    );
  }
}
