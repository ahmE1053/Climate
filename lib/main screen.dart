import 'package:flutter/material.dart';
import 'convert.dart';
import 'package:google_fonts/google_fonts.dart';

class Main extends StatefulWidget {
  Main(this.Weather);
  final Weather;
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  Convert con = Convert();
  @override
  void initState() {
    super.initState();
    con.set(widget.Weather);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    print(mediaQ.textScaleFactor);
    return Scaffold(
        backgroundColor: const Color(0xff171848),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: mediaQ.textScaleFactor > 1.3
                        ? mediaQ.orientation == Orientation.portrait
                            ? mediaQ.size.height * 0.84
                            : mediaQ.size.height * 2
                        : mediaQ.orientation == Orientation.portrait
                            ? mediaQ.size.height * .87
                            : mediaQ.size.height * 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff35366d),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(
                                    'درجة الحرارة دلوقتي',
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.amiri(
                                      fontSize: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    '${con.temp} c',
                                    style: GoogleFonts.lobster(
                                      fontSize: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff35366d),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          'أقصى درجة حرارة',
                                          textDirection: TextDirection.rtl,
                                          style: GoogleFonts.amiri(
                                            fontSize: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          '${con.tempmax} c',
                                          style: GoogleFonts.lobster(
                                            fontSize: 60,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff35366d),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          'أقل درجة حرارة ',
                                          textDirection: TextDirection.rtl,
                                          style: GoogleFonts.amiri(
                                            fontSize: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          '${con.tempmin} c',
                                          style: GoogleFonts.lobster(
                                            fontSize: 60,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff35366d),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          'سرعة الرياح',
                                          textDirection: TextDirection.rtl,
                                          style: GoogleFonts.amiri(
                                            fontSize: 35,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          '${con.windspeed} ',
                                          style: GoogleFonts.lobster(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          'متر/ الثانية',
                                          textDirection: TextDirection.rtl,
                                          style: GoogleFonts.amiri(
                                            fontSize: 25,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff35366d),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          'المدينة',
                                          textDirection: TextDirection.rtl,
                                          style: GoogleFonts.amiri(
                                            fontSize: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          '${con.name}',
                                          textDirection: TextDirection.rtl,
                                          style: GoogleFonts.amiri(
                                            fontSize: 35,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  color: Colors.pink,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        'أرجع للشاشة الرئيسية',
                        style: GoogleFonts.amiri(
                          fontSize: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
