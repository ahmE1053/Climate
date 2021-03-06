import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'result_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Helpers/get_weather_api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../Helpers/text_direction_funtion.dart';

class SelectingScreen extends StatefulWidget {
  const SelectingScreen({Key? key}) : super(key: key);
  @override
  State<SelectingScreen> createState() => _SelectingScreenState();
}

double? long, lat;

class _SelectingScreenState extends State<SelectingScreen> {
  Future<int> _checkPermission() async {
    final onorof = await Permission.location.serviceStatus;
    if (onorof == ServiceStatus.disabled) {
      return 2;
    }
    final status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
    } else if (status == PermissionStatus.denied) {
      return 3;
    } else if (status == PermissionStatus.permanentlyDenied) {
      return 1;
    }
    return 0;
  }

  weather obj = weather();
  String? cit;

  final ValueNotifier<TextDirection> _textDir =
      ValueNotifier(TextDirection.ltr);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0xFF1b0438)));
    final mediaQ = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: LoaderOverlay(
          useDefaultLoading: false,
          overlayOpacity: 0,
          overlayWidget: const Center(
            child: SpinKitWave(
              color: Colors.red,
              size: 150.0,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF0f0621),
                    Color(0xFF1b0438),
                    Color(0xFF0f0621),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 0.7, 1.0],
                  tileMode: TileMode.mirror),
            ),
            height: double.infinity,
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: mediaQ.orientation == Orientation.portrait
                  ? PortraitWidget(mediaQ, context)
                  : LandscapeWidget(mediaQ, context),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView LandscapeWidget(
      MediaQueryData mediaQ, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ValueListenableBuilder<TextDirection>(
              valueListenable: _textDir,
              builder: (context, value, child) {
                return TextField(
                  onChanged: (input) {
                    cit = input;
                    if (input.trim().length < 2) {
                      final dir = getDirection(input);
                      if (dir != value) _textDir.value = dir;
                    }
                  },
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textDirection: value,
                  decoration: const InputDecoration(
                    hintText: '???????? ?????? ?????????????? ??????',
                    hintStyle: TextStyle(fontSize: 15),
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    icon: Icon(
                      Icons.location_city,
                      size: 40,
                      color: Colors.white70,
                    ),
                    filled: true,
                    fillColor: Colors.white24,
                  ),
                );
              }),
          SizedBox(
            height: mediaQ.size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: mediaQ.size.width * 0.05,
              ),
              GestureDetector(
                onTap: () async {
                  int a = await _checkPermission();
                  if (a == 2) {
                    Alert(
                      context: context,
                      title: "??????????",
                      desc: "???????????????? ??????????. ?????????? ???????? ?????????????? ??????????",
                      buttons: [
                        DialogButton(
                          child: const Text('????????'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ).show();
                    obj.getweather();
                    return;
                  }
                  if (a == 3) {
                    Alert(
                      context: context,
                      title: "??????????",
                      desc: "?????? ???? ?????? ?????? ???????????????? ?????? ???????? ?????????? ??????.",
                      buttons: [
                        DialogButton(
                          child: const Text('????????'),
                          onPressed: () async {
                            final status = await Permission.location.request();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                    return;
                  }
                  if (a == 1) {
                    Alert(
                      context: context,
                      title: "??????????",
                      desc:
                          "?????? ???????? ???????????????? ???? ?????? ???????? ???????? ?????? ???????? ??????????. ???? ???????????? ???? ??????????????????",
                      buttons: [
                        DialogButton(
                          child: const Text('????????'),
                          onPressed: () async {
                            await openAppSettings();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                    return;
                  }
                  context.loaderOverlay.show();
                  dynamic dataa = await obj.getweather();
                  context.loaderOverlay.hide();
                  if (dataa == 404) {
                    Alert(
                      context: context,
                      title: "??????????",
                      desc: "???? ?????????? ?? ???????? ???????? ???? ??????????????",
                      buttons: [
                        DialogButton(
                          child: const Text('????????'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Main(dataa);
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xff1c142c),
                  ),
                  child: const FittedBox(
                    child: Text(
                      '?????????? ????????',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  height: mediaQ.size.height * 0.4,
                  width: mediaQ.size.width * 0.3,
                ),
              ),
              SizedBox(
                width: mediaQ.size.width * 0.2,
              ),
              GestureDetector(
                onTap: () async {
                  int a = await _checkPermission();
                  if (a == 2) {
                    Alert(
                      context: context,
                      title: "??????????",
                      desc: "???????????????? ??????????. ?????????? ???????? ?????????????? ??????????",
                      buttons: [
                        DialogButton(
                          child: const Text('????????'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ).show();
                    obj.getweather();
                    return;
                  }
                  if (a == 3) {
                    Alert(
                      context: context,
                      title: "??????????",
                      desc: "?????? ???? ?????? ?????? ???????????????? ?????? ???????? ?????????? ??????.",
                      buttons: [
                        DialogButton(
                          child: const Text('????????'),
                          onPressed: () async {
                            final status = await Permission.location.request();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                    return;
                  }
                  if (a == 1) {
                    Alert(
                      context: context,
                      title: "??????????",
                      desc:
                          "?????? ???????? ???????????????? ???? ?????? ???????? ???????? ?????? ???????? ??????????. ???? ???????????? ???? ??????????????????",
                      buttons: [
                        DialogButton(
                          child: const Text('????????'),
                          onPressed: () async {
                            await openAppSettings();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                    return;
                  }
                  if (cit == "" || cit == null) {
                    Alert(
                      context: context,
                      title: "??????????",
                      desc: "???????????? ???????? ???????? ?????????????? ????????",
                      buttons: [
                        DialogButton(
                          child: const Text('????????'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                    return;
                  }
                  context.loaderOverlay.show();
                  dynamic dataa = await obj.getweathercity(cit!);
                  context.loaderOverlay.hide();
                  if (dataa == 404) {
                    Alert(
                      context: context,
                      title: "??????????",
                      desc: "???? ?????????? ?? ???????? ???????? ???? ?????????????? ???? ???????? ???????? ??????",
                      buttons: [
                        DialogButton(
                          child: const Text('????????'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Main(dataa);
                      },
                    ),
                  );
                },
                child: Container(
                  height: mediaQ.size.height * 0.4,
                  width: mediaQ.size.width * 0.3,
                  // margin: EdgeInsets.all(40),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xff1c142c),
                  ),
                  child: const Center(
                    child: FittedBox(
                      child: Text(
                        '?????????? ???? ???????? ????????',
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: mediaQ.size.width * 0.05,
              ),
            ],
          )
        ],
      ),
    );
  }

  SingleChildScrollView PortraitWidget(
      MediaQueryData mediaQ, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<TextDirection>(
              valueListenable: _textDir,
              builder: (context, value, child) {
                return TextField(
                  onChanged: (input) {
                    cit = input;
                    if (input.trim().length < 2) {
                      final dir = getDirection(input);
                      if (dir != value) _textDir.value = dir;
                    }
                  },
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textDirection: value,
                  decoration: const InputDecoration(
                    hintText: '???????? ?????? ?????????????? ??????',
                    hintStyle: TextStyle(fontSize: 15),
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    icon: Icon(
                      Icons.location_city,
                      size: 40,
                      color: Colors.white70,
                    ),
                    filled: true,
                    fillColor: Colors.white24,
                  ),
                );
              }),
          SizedBox(
            height: mediaQ.size.height * 0.15,
          ),
          GestureDetector(
            onTap: () async {
              int a = await _checkPermission();
              if (a == 2) {
                Alert(
                  context: context,
                  title: "??????????",
                  desc: "???????????????? ??????????. ?????????? ???????? ?????????????? ??????????",
                  buttons: [
                    DialogButton(
                      child: const Text('????????'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ).show();
                obj.getweather();
                return;
              }
              if (a == 3) {
                Alert(
                  context: context,
                  title: "??????????",
                  desc: "?????? ???? ?????? ?????? ???????????????? ?????? ???????? ?????????? ??????.",
                  buttons: [
                    DialogButton(
                      child: const Text('????????'),
                      onPressed: () async {
                        final status = await Permission.location.request();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show();
                return;
              }
              if (a == 1) {
                Alert(
                  context: context,
                  title: "??????????",
                  desc:
                      "?????? ???????? ???????????????? ???? ?????? ???????? ???????? ?????? ???????? ??????????. ???? ???????????? ???? ??????????????????",
                  buttons: [
                    DialogButton(
                      child: const Text('????????'),
                      onPressed: () async {
                        await openAppSettings();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show();
                return;
              }
              context.loaderOverlay.show();
              dynamic dataa = await obj.getweather();
              context.loaderOverlay.hide();
              if (dataa == 404) {
                Alert(
                  context: context,
                  title: "??????????",
                  desc: "???? ?????????? ?? ???????? ???????? ???? ??????????????",
                  buttons: [
                    DialogButton(
                      child: const Text('????????'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show();
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Main(dataa);
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xff1c142c),
              ),
              child: const FittedBox(
                child: Text(
                  '?????????? ????????',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              height: mediaQ.size.height * 0.25,
              width: mediaQ.size.width * 0.7,
            ),
          ),
          SizedBox(
            height: mediaQ.size.height * 0.15,
          ),
          GestureDetector(
            onTap: () async {
              int a = await _checkPermission();
              if (a == 2) {
                Alert(
                  context: context,
                  title: "??????????",
                  desc: "???????????????? ??????????. ?????????? ???????? ?????????????? ??????????",
                  buttons: [
                    DialogButton(
                      child: const Text('????????'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ).show();
                obj.getweather();
                return;
              }
              if (a == 3) {
                Alert(
                  context: context,
                  title: "??????????",
                  desc: "?????? ???? ?????? ?????? ???????????????? ?????? ???????? ?????????? ??????.",
                  buttons: [
                    DialogButton(
                      child: const Text('????????'),
                      onPressed: () async {
                        final status = await Permission.location.request();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show();
                return;
              }
              if (a == 1) {
                Alert(
                  context: context,
                  title: "??????????",
                  desc:
                      "?????? ???????? ???????????????? ???? ?????? ???????? ???????? ?????? ???????? ??????????. ???? ???????????? ???? ??????????????????",
                  buttons: [
                    DialogButton(
                      child: const Text('????????'),
                      onPressed: () async {
                        await openAppSettings();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show();
                return;
              }
              if (cit == "" || cit == null) {
                Alert(
                  context: context,
                  title: "??????????",
                  desc: "???????????? ???????? ???????? ?????????????? ????????",
                  buttons: [
                    DialogButton(
                      child: const Text('????????'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show();
                return;
              }
              context.loaderOverlay.show();
              dynamic dataa = await obj.getweathercity(cit!);
              context.loaderOverlay.hide();
              if (dataa == 404) {
                Alert(
                  context: context,
                  title: "??????????",
                  desc: "???? ?????????? ?? ???????? ???????? ???? ?????????????? ???? ???????? ???????? ??????",
                  buttons: [
                    DialogButton(
                      child: const Text('????????'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show();
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Main(dataa);
                  },
                ),
              );
            },
            child: Container(
              height: mediaQ.size.height * 0.25,
              width: mediaQ.size.width * 0.7,
              margin: const EdgeInsets.all(40),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xff1c142c),
              ),
              child: const Center(
                child: FittedBox(
                  child: Text(
                    '?????????? ???? ???????? ????????',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
