// import 'package:app/configs/text_styles.dart';
// import 'package:flutter/material.dart';

// class AppErrorWidget extends StatelessWidget {
//   final FlutterErrorDetails errorDetails;
//   final bool isDev;
//   const AppErrorWidget({
//     Key? key,
//     required this.errorDetails,
//     this.isDev = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightGreen[500],
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 30),
//           child: ListView(
//             children: <Widget>[
//               Center(
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 80,
//                   child: Text(
//                     '에러에도 화내지 않는 당신은 프로!',
//                     style: IcoTextStyle.boldTextStyle22B,
//                   ),
//                 ),
//               ),
//               Text(isDev ? errorDetails.toString() : '')
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
