import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/screens/movie/components/movie_list_.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MovieListScreen());
  }
}
