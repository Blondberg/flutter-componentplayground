import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/constants.dart';
import 'package:flutter_componentplayground/screens/movie/components/movie_list_.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kDefaultBackground,
        // gradient: RadialGradient(
        //   colors: [
        //     Color(0xFFAA9AFF),
        //     Color.lerp(Color(0xFFAA9AFF), Color(0xFF63B4FF), 0.2)!,
        //     Color(0xFF63B4FF)
        //   ],
        //   center: Alignment.topLeft,
        //   stops: [0, 0.5, 1],
        //   radius: 1,
        // ),
      ),
      child: const Scaffold(body: MovieListScreen()),
    );
  }
}
