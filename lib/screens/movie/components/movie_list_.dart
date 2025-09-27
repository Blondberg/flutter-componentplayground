import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_componentplayground/constants.dart';
import 'package:flutter_componentplayground/screens/movie/components/movie_detail_screen.dart';
import 'package:flutter_componentplayground/screens/movie/components/movie_list_item.dart';
import 'package:flutter_componentplayground/screens/selection_button/components/BubbleMenu.dart';
import 'package:flutter_componentplayground/screens/selection_button/components/BubbleMenuItem.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<dynamic>? movies;
  late List<dynamic> moviesDuplicate = <dynamic>[];
  final FocusNode _textFocus = FocusNode();

  TextEditingController _editingController = TextEditingController();

  final List<Color> _itemColors = [
    Color(0xff8685EF),
  ];

  void filterSearchResults(String query, {String field = "Title"}) {
    List<dynamic> dummyList = <dynamic>[];
    dummyList.addAll(moviesDuplicate);

    if (query.isNotEmpty) {
      List<dynamic> dummyListData = <dynamic>[];
      dummyList.forEach((element) {
        if (element[field]
            .toString()
            .toLowerCase()
            .replaceAll(' ', '')
            .contains(query.toLowerCase().replaceAll(' ', ''))) {
          dummyListData.add(element);
        }
      });
      setState(() {
        movies?.clear();
        movies?.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        movies?.clear();
        movies?.addAll(moviesDuplicate);
      });
    }
  }

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/movies.json');
    setState(() {
      movies = jsonDecode(jsonText);
      moviesDuplicate.addAll(movies!);
    });
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Movie List",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                        color: kDefaultText,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(left: 5, right: 5),
                width: size.width * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kDefaultFrame,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          FocusScope.of(context).requestFocus(_textFocus),
                      child: SvgPicture.asset(
                        "assets/svg/searchshort.svg",
                        color: kDefaultText.withOpacity(.6),
                        height: 15,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _textFocus,
                        onChanged: (value) => filterSearchResults(value),
                        controller: _editingController,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Search",
                          border: InputBorder.none,
                          hoverColor: Colors.transparent,
                        ),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          color: kDefaultText.withOpacity(.6),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () => setState(
                        () {
                          _editingController.clear();
                          filterSearchResults("");
                        },
                      ),
                      icon: Icon(Icons.close_rounded,
                          size: 20,
                          color: _editingController.text != ''
                              ? kDefaultText.withOpacity(.6)
                              : Colors.transparent),
                    ),
                    Icon(
                      Icons.filter_list_rounded,
                      color: kDefaultText.withOpacity(.6),
                      size: 20,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.purple,
                        Colors.transparent,
                      ],
                      stops: [
                        0.0,
                        0.0,
                      ], // 10% purple, 80% transparent, 10% purple
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    shrinkWrap: true,
                    itemCount: movies == null ? 0 : (movies?.length)! + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == movies?.length) {
                        return const SizedBox(
                          height: 100,
                        );
                      }
                      return MovieListItem(
                          index: index,
                          movies: movies,
                          itemColors: _itemColors,
                          size: size);
                    },
                  ),
                ),
              )
            ],
          ),
          BubbleMenu(
            items: [
              BubbleMenuItem(
                icon: Icon(
                  Icons.search_rounded,
                  color: kDefaultText,
                  size: 15,
                ),
                onTap: () async {
                  String barcodeScanRes =
                      await FlutterBarcodeScanner.scanBarcode(
                          "red", "cancel", false, ScanMode.BARCODE);
                  setState(() {
                    _editingController.text = barcodeScanRes;
                  });
                  filterSearchResults(barcodeScanRes, field: "Barcode");
                },
              ),
              BubbleMenuItem(
                icon: Icon(
                  Icons.add_rounded,
                  color: kDefaultText,
                  size: 15,
                ),
                onTap: () => print("Scan to add"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
