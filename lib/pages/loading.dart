import 'package:app/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// class LoadingPage extends StatefulWidget {
//   LoadingPage({Key? key}) : super(key: key);
//   @override
//   State<LoadingPage> createState() => _LoadingPage();
// }

// class _LoadingPage extends State<LoadingPage> with TickerProviderStateMixin {
//   late final AnimationController _controller = AnimationController(
//     duration: const Duration(milliseconds: 890),
//     vsync: this,
//   )..repeat(reverse: true);
//   late final Animation<double> _animation = CurvedAnimation(
//     parent: _controller,
//     curve: Curves.easeOut,
//   );

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         width: Get.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // FadeTransition(
//             //   opacity: _animation,
//             //   child: Image.asset(
//             //     'images/loading.png',
//             //     width: Get.width - 280,
//             //   ),
//             // ),
//             Lottie.asset('assets/loading2.json',
//                 repeat: true, reverse: true, animate: true, width: 100),
//           ],
//         ),
//       ),
//     );
//   }
// }

Future<dynamic> startLoadingIndicator() {
  return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/loading2.json',
              repeat: true, reverse: true, animate: true, width: 90),
        ],
      ),
      barrierColor: Colors.white30,
      barrierDismissible: false);
}

finishLoadingIndicator() {
  Get.back();
}
