import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'main screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'weather.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'text_direction_funtion.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

double? long, lat;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        SystemUiOverlayStyle(statusBarColor: Color(0xFF1b0438)));
    final mediaQ = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: LoaderOverlay(
          useDefaultLoading: false,
          overlayOpacity: 0,
          overlayWidget: Center(
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
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: mediaQ.orientation == Orientation.portrait
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                    hintText: 'أكتب اسم المدينة هنا',
                                    hintStyle: TextStyle(fontSize: 15),
                                    hintTextDirection: TextDirection.rtl,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
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
                            height: mediaQ.size.height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () async {
                              int a = await _checkPermission();
                              if (a == 2) {
                                Alert(
                                  context: context,
                                  title: "مشكلة",
                                  desc:
                                      "اللوكيشن مقفول. افتحه عشان التطبيق يشتغل",
                                  buttons: [
                                    DialogButton(
                                      child: Text('تمام'),
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
                                  title: "مشكلة",
                                  desc:
                                      "انت مش مدي اذن للبرنامج انه يعرف مكانك فين.",
                                  buttons: [
                                    DialogButton(
                                      child: Text('تمام'),
                                      onPressed: () async {
                                        final status =
                                            await Permission.location.request();
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
                                  title: "مشكلة",
                                  desc:
                                      "انت مانع البرنامج من انه يطلب تاني انه يعرف مكانك. خش افتحها من الاعدادات",
                                  buttons: [
                                    DialogButton(
                                      child: Text('تمام'),
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
                                  title: "مشكلة",
                                  desc: "في مشكلة ف النت عندك او السيرفر",
                                  buttons: [
                                    DialogButton(
                                      child: Text('تمام'),
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
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff1c142c),
                              ),
                              child: const FittedBox(
                                child: Text(
                                  'الطقس عندك',
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
                            height: mediaQ.size.height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () async {
                              int a = await _checkPermission();
                              if (a == 2) {
                                Alert(
                                  context: context,
                                  title: "مشكلة",
                                  desc:
                                      "اللوكيشن مقفول. افتحه عشان التطبيق يشتغل",
                                  buttons: [
                                    DialogButton(
                                      child: Text('تمام'),
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
                                  title: "مشكلة",
                                  desc:
                                      "انت مش مدي اذن للبرنامج انه يعرف مكانك فين.",
                                  buttons: [
                                    DialogButton(
                                      child: Text('تمام'),
                                      onPressed: () async {
                                        final status =
                                            await Permission.location.request();
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
                                  title: "مشكلة",
                                  desc:
                                      "انت مانع البرنامج من انه يطلب تاني انه يعرف مكانك. خش افتحها من الاعدادات",
                                  buttons: [
                                    DialogButton(
                                      child: Text('تمام'),
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
                                  title: "مشكلة",
                                  desc: "مينفعش تسيب مكان المدينة فاضي",
                                  buttons: [
                                    DialogButton(
                                      child: const Text('تمام'),
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
                                  title: "مشكلة",
                                  desc:
                                      "في مشكلة ف النت عندك او السيرفر او دخلت مكان غلط",
                                  buttons: [
                                    DialogButton(
                                      child: const Text('تمام'),
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
                              margin: EdgeInsets.all(40),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff1c142c),
                              ),
                              child: const Center(
                                child: FittedBox(
                                  child: Text(
                                    'الطقس في مكان تاني',
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
                    )
                  : SingleChildScrollView(
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
                                    hintText: 'أكتب اسم المدينة هنا',
                                    hintStyle: TextStyle(fontSize: 15),
                                    hintTextDirection: TextDirection.rtl,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
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
                                      title: "مشكلة",
                                      desc:
                                          "اللوكيشن مقفول. افتحه عشان التطبيق يشتغل",
                                      buttons: [
                                        DialogButton(
                                          child: Text('تمام'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
                                      ],
                                    ).show();
                                    obj.getweather();
                                    return;
                                  }
                                  if (a == 3) {
                                    Alert(
                                      context: context,
                                      title: "مشكلة",
                                      desc:
                                          "انت مش مدي اذن للبرنامج انه يعرف مكانك فين.",
                                      buttons: [
                                        DialogButton(
                                          child: Text('تمام'),
                                          onPressed: () async {
                                            final status = await Permission
                                                .location
                                                .request();
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
                                      title: "مشكلة",
                                      desc:
                                          "انت مانع البرنامج من انه يطلب تاني انه يعرف مكانك. خش افتحها من الاعدادات",
                                      buttons: [
                                        DialogButton(
                                          child: Text('تمام'),
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
                                      title: "مشكلة",
                                      desc: "في مشكلة ف النت عندك او السيرفر",
                                      buttons: [
                                        DialogButton(
                                          child: Text('تمام'),
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
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xff1c142c),
                                  ),
                                  child: const FittedBox(
                                    child: Text(
                                      'الطقس عندك',
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
                                      title: "مشكلة",
                                      desc:
                                          "اللوكيشن مقفول. افتحه عشان التطبيق يشتغل",
                                      buttons: [
                                        DialogButton(
                                          child: Text('تمام'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
                                      ],
                                    ).show();
                                    obj.getweather();
                                    return;
                                  }
                                  if (a == 3) {
                                    Alert(
                                      context: context,
                                      title: "مشكلة",
                                      desc:
                                          "انت مش مدي اذن للبرنامج انه يعرف مكانك فين.",
                                      buttons: [
                                        DialogButton(
                                          child: Text('تمام'),
                                          onPressed: () async {
                                            final status = await Permission
                                                .location
                                                .request();
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
                                      title: "مشكلة",
                                      desc:
                                          "انت مانع البرنامج من انه يطلب تاني انه يعرف مكانك. خش افتحها من الاعدادات",
                                      buttons: [
                                        DialogButton(
                                          child: Text('تمام'),
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
                                      title: "مشكلة",
                                      desc: "مينفعش تسيب مكان المدينة فاضي",
                                      buttons: [
                                        DialogButton(
                                          child: const Text('تمام'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ).show();
                                    return;
                                  }
                                  context.loaderOverlay.show();
                                  dynamic dataa =
                                      await obj.getweathercity(cit!);
                                  context.loaderOverlay.hide();
                                  if (dataa == 404) {
                                    Alert(
                                      context: context,
                                      title: "مشكلة",
                                      desc:
                                          "في مشكلة ف النت عندك او السيرفر او دخلت مكان غلط",
                                      buttons: [
                                        DialogButton(
                                          child: const Text('تمام'),
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
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xff1c142c),
                                  ),
                                  child: const Center(
                                    child: FittedBox(
                                      child: Text(
                                        'الطقس في مكان تاني',
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
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
