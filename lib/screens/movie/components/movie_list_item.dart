import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/screens/movie/components/movie_detail_screen.dart';

import '../../../constants.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({
    Key? key,
    required this.movies,
    required List<Color> itemColors,
    required this.size,
    required this.index,
  })  : _itemColors = itemColors,
        super(key: key);

  final List? movies;
  final List<Color> _itemColors;
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MovieDetailScreen(
            movieData: movies![index],
            color: _itemColors[index % _itemColors.length],
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(0xFF202020).withOpacity(.9),
          borderRadius: BorderRadius.circular(15),
        ),
        width: size.width,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Flexible(
              child: RichText(
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "${movies![index]["Title"]} \n",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text:
                          "Y: ${movies![index]["Year"] != "" ? movies![index]["Year"] : "N/A"}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
