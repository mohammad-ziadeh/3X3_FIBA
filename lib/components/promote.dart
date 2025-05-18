// import 'package:flutter/material.dart';

// class Promote extends StatelessWidget {
//   const Promote({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double sectionHeight = MediaQuery.of(context).size.height * 0.4;

//     return Column(
//       children: [
//         // Top Section
//         Container(
//           height: sectionHeight,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               // Background Image (Person sitting)
//               Image.asset(
//                 'assets/images/section1.jpeg',
//                 fit: BoxFit.cover,
//               ),

//               // Overlay Content
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     // SHOP Button
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       color: Colors.red,
//                       child: Text(
//                         'SHOP',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),
//                     // Title: BUY YOUR 3X3 APPAREL
//                     Text(
//                       'BUY YOUR 3X3\nAPPAREL',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Bottom Section
//         Container(
//           height: sectionHeight,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               // Background Image (Basketballs)
//               Image.asset(
//                 'assets/images/section2.jpeg',
//                 fit: BoxFit.cover,
//               ),

//               // Overlay Content
//               Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // WILSON Button
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       color: Colors.red,
//                       child: Text(
//                         'WILSON',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),
//                     // Title: GET THE OFFICIAL BALL!
//                     Text(
//                       'GET THE OFFICIAL BALL!',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }