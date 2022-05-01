// import 'package:flutter/material.dart';
// import 'convert.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class City extends StatefulWidget {
//   City(this.Weather);
//   final Weather;
//   @override
//   State<City> createState() => _CityState();
// }
//
// class _CityState extends State<City> {
//   Convert con = Convert();
//   @override
//   void initState() {
//     super.initState();
//     con.set(widget.Weather);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff171848),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Color(0xff35366d),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FittedBox(
//                     child: Text(
//                       'درجة الحرارة دلوقتي',
//                       style: GoogleFonts.amiri(
//                         fontSize: 15,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   FittedBox(
//                     child: Text(
//                       '${con.temp}',
//                       style: GoogleFonts.lobster(
//                         fontSize: 40,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Color(0xff35366d),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FittedBox(
//                             child: Text(
//                               'أقصى درجة حرارة',
//                               style: GoogleFonts.amiri(
//                                 fontSize: 40,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           FittedBox(
//                             child: Text(
//                               '${con.tempmax}',
//                               style: GoogleFonts.lobster(
//                                 fontSize: 60,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Color(0xff35366d),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FittedBox(
//                             child: Text(
//                               'أقل درجة حرارة ',
//                               style: GoogleFonts.amiri(
//                                 fontSize: 40,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           FittedBox(
//                             child: Text(
//                               '${con.tempmin}',
//                               style: GoogleFonts.lobster(
//                                 fontSize: 60,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Color(0xff35366d),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FittedBox(
//                             child: Text(
//                               'سرعة الرياح',
//                               style: GoogleFonts.amiri(
//                                 fontSize: 40,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           FittedBox(
//                             child: Text(
//                               '${con.windspeed} ',
//                               style: GoogleFonts.lobster(
//                                 fontSize: 60,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           FittedBox(
//                             child: Text(
//                               'متر/ الثانية',
//                               style: GoogleFonts.amiri(
//                                 fontSize: 40,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Color(0xff35366d),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FittedBox(
//                             child: Text(
//                               'المدينة',
//                               style: GoogleFonts.amiri(
//                                 fontSize: 40,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           FittedBox(
//                             child: Text(
//                               '${con.name}',
//                               style: GoogleFonts.amiri(
//                                 fontSize: 60,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 height: 100,
//                 width: double.infinity,
//                 color: Colors.pink,
//                 child: Center(
//                   child: FittedBox(
//                     child: Text(
//                       'أرجع للشاشة الرئيسية',
//                       style: GoogleFonts.amiri(
//                         fontSize: 60,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
