// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:scanpackage/controller/user_controller.dart';
// import 'package:scanpackage/contstants/app_strings.dart';
// import 'package:scanpackage/contstants/colors.dart';
// import 'package:scanpackage/contstants/image_path.dart';
// import 'package:scanpackage/screen/auth/login_screen.dart';
// import 'package:scanpackage/screen/home/home_screen.dart';
// import 'package:scanpackage/screen/settings/settings_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

// class DrawerWidget extends StatelessWidget {
//   final UserController userController = Get.find();

//   DrawerWidget({super.key});

//   void _logout(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           title:
//               Text('confirmLogout'.tr, style: GoogleFonts.inter(fontSize: 18)),
//           content: Text('confirmLogoutDes'.tr),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child:
//                   Text('no'.tr, style: GoogleFonts.inter(color: Colors.black)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Get.offAll(() => const LoginScreen());
//                 Future.delayed(
//                   const Duration(seconds: 1),
//                   () => userController.clearUser(),
//                 );
//               },
//               child: Text('yes'.tr,
//                   style: GoogleFonts.inter(color: primaryRedColor)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showStoreSelection(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: Colors.white,
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Select Store',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: userController.user.value?.allStores?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     final store = userController.user.value!.allStores![index];
//                     return Column(
//                       children: [
//                         ListTile(
//                           selected:
//                               store == userController.user.value!.storeAddress,
//                           selectedColor: Colors.blue.shade600,
//                           title: Text(store),
//                           onTap: () {
//                             userController.changeStore(store);
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         const Divider(
//                           color: lightGreyBorder,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _launchUrl(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   Widget _drawerHeader(UserController userController) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(16),
//           bottomRight: Radius.circular(16),
//         ),
//         gradient: LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           colors: [
//             Color(0xFFED9C97),
//             Color(0xFFE45D7F),
//           ],
//         ),
//       ),
//       child: SafeArea(
//         child: Obx(
//           () {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Row to display CircleAvatar, Name, and Email in the same row
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       maxRadius: 30,
//                       backgroundColor: redColor,
//                       child: Text(
//                         userController.user.value?.firstName?.substring(0, 1) ??
//                             '',
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
                   
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${userController.user.value?.r ?? ''} ${userController.user.value?.lastName ?? ''}",
//                           style: GoogleFonts.inter(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           userController.user.value?.email ?? '',
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   ListTile _drawerTile({
//     required String svgIconPath, // Path to the SVG asset
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: SvgPicture.asset(
//         svgIconPath,
//         width: 24, // You can adjust the size based on your needs
//         height: 24,
//       ),
//       title: Text(title.tr),
//       onTap: onTap,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.white,
//       child: Column(
//         children: [
//           _drawerHeader(userController),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _drawerTile(
//                   svgIconPath: 'assets/svg/home.svg',
//                   title: 'Home',
//                   onTap: () {
//                     Get.to(() => const HomeScreen(),
//                         transition: Transition.rightToLeft,
//                         duration: const Duration(milliseconds: 400));
//                   },
//                 ),
          
           
//                 _drawerTile(
//                   svgIconPath: 'assets/svg/setting.svg', 
//                   title: 'settingsTitle',
//                   onTap: () {
//                     Get.to(() => SettingsScreen(),
//                         transition: Transition.rightToLeft,
//                         duration: const Duration(milliseconds: 400));
//                   },
//                 ),
//                 _drawerTile(
//                   svgIconPath: 'assets/svg/policy.svg', 
//                   title: 'privacyPolicyTitle',
//                   onTap: () => _launchUrl(AppStrings.privacyPolicyUrl),
//                 ),
//                 _drawerTile(
//                   svgIconPath: 'assets/svg/support.svg', 
//                   title: 'support',
//                   onTap: () => _launchUrl(AppStrings.supportUrl),
//                 ),
//                 if (userController.user.value != null &&
//                     userController.user.value!.allStores!.length > 1)
//                   _drawerTile(
//                     svgIconPath: 'assets/svg/store.svg', 
//                     title: 'Switch Store',
//                     onTap: () {
//                       _showStoreSelection(context);
//                     },
//                   ),
//                 _drawerTile(
//                   svgIconPath: 'assets/svg/logout.svg', 
//                   title: 'logout',
//                   onTap: () => _logout(context),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(AppStrings.powerdBy,
//                     style: TextStyle(fontSize: 15, color: Colors.grey)),
//                 Image.asset(ImagePaths.appBlackLogo, width: 85),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
