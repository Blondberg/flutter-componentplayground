import 'package:flutter/material.dart';
import 'package:flutter_componentplayground/constants.dart';
import 'package:flutter_componentplayground/screens/movie/components/my_appbar_item.dart';

class MovieEditScreen extends StatefulWidget {
  const MovieEditScreen({Key? key}) : super(key: key);

  @override
  State<MovieEditScreen> createState() => _MovieEditScreenState();
}

Future<bool> showAlertDialog(BuildContext context) async {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel", style: TextStyle(color: Colors.white)),
    onPressed: () {
      Navigator.of(context).pop(false);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes", style: TextStyle(color: Colors.white)),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Sure?", style: TextStyle(color: Colors.white)),
    backgroundColor: kPrimaryRed,
    content: const Text("""
Are you sure you want to exit the editing screen? Any unsaved progress will be removed!""",
        style: TextStyle(color: Colors.white)),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  final result = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  return result;
}

class _MovieEditScreenState extends State<MovieEditScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 10, right: 30, left: 30),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyAppBarItem(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Color(0xffFF7360),
                      ),
                      onTap: () async {
                        if (await showAlertDialog(context)) {
                          Navigator.of(context).pop();
                        }
                      },
                      color: const Color(0xffFF7360),
                    ),
                    MyAppBarItem(
                      icon: const Icon(
                        Icons.check_rounded,
                        color: Color.fromARGB(255, 127, 158, 103),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                      color: const Color.fromARGB(255, 127, 158, 103),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
