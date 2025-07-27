// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:mycic_app/core/core.dart';
// import 'package:mycic_app/presentation/screens/jadwal_page.dart';
// import 'package:mycic_app/presentation/screens/profile_page.dart';
// import 'package:mycic_app/presentation/screens/transkrip_page.dart';
// import 'package:mycic_app/presentation/widgets/all_menu.dart';
// import 'package:mycic_app/presentation/screens/class_page.dart';
// import 'package:mycic_app/presentation/widgets/header_widget.dart';
// import 'package:mycic_app/presentation/widgets/menu_item_tile.dart';
// import 'package:mycic_app/presentation/widgets/my_kelas_banner.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     int _current = 0; // di dalam StatefulWidget
//     final List<Widget> bannerItems = [
//       // Salin isi Container kamu di sini 3x, atau generate dinamis
//       MyKelasBanner(title: 'Pemrograman Internet', time: '14:00'),
//       MyKelasBanner(title: 'Struktur Data', time: '09:00'),
//       MyKelasBanner(title: 'Basis Data', time: '11:00'),
//     ];

//     final menuItems = [
//       {
//         'title': 'Jadwal',
//         'icon': Assets.images.menu.jadwal,
//         'page': JadwalPage(),
//       },
//       {'title': 'Kelas', 'icon': Assets.images.menu.kelas, 'page': ClassPage()},
//       {
//         'title': 'Transkrip',
//         'icon': Assets.images.menu.transkrip,
//         'page': TranskripPage(),
//       },
//       {'title': 'Nilai KHS', 'icon': Assets.images.menu.khs, 'page': null},
//       {'title': 'Ujian', 'icon': Assets.images.menu.ujian, 'page': null},
//       {'title': 'Skripsi', 'icon': Assets.images.menu.skripsi, 'page': null},
//       {
//         'title': 'Informasi',
//         'icon': Assets.images.menu.informasi,
//         'page': null,
//       },
//       {'title': 'Semua', 'icon': Assets.images.menu.semua, 'page': null},
//     ];

//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             HeaderWidget(
//               profileImageUrl: 'https://via.placeholder.com/150',
//               onNotificationTap: () {},
//               onProfileTap: () {
//                 // ProfilePage();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProfilePage()),
//                 );
//               },
//             ),
//             const Text(
//               'Halo, Mas Sahal 👋',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const Text(
//               'Teknik Informatika - IV',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),

//             // Banner
//             Column(
//               children: [
//                 CarouselSlider(
//                   items: bannerItems,
//                   options: CarouselOptions(
//                     height: 150, // sesuaikan
//                     enlargeCenterPage: true,
//                     autoPlay: true,
//                     viewportFraction: 1,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         _current = index;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(bannerItems.length, (index) {
//                     return Container(
//                       width: 8.0,
//                       height: 8.0,
//                       margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color:
//                             _current == index
//                                 ? AppColors.primary
//                                 : Colors.grey[300],
//                       ),
//                     );
//                   }),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header Menu
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Menu',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/all-menu');
//                       },
//                       child: const Text('All'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 // Grid Menu
//                 GridView.count(
//                   padding: EdgeInsets.zero, // tambahkan ini!
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   crossAxisCount: 4,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 30,

//                   children:
//                       menuItems.map((item) {
//                         return MenuItemTile(
//                           title: item['title'] as String,
//                           iconData: item['icon'] as AssetGenImage,
//                           onTap: () {
//                             // navigasi ke jadwal

//                             if (item['title'] == 'Semua') {
//                               showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled: true,
//                                 backgroundColor: Colors.white,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.vertical(
//                                     top: Radius.circular(16),
//                                   ),
//                                 ),
//                                 builder:
//                                     (context) =>
//                                         const AllMenu(), // Panggil widget terpisah
//                               );
//                             } else {
//                               // route page push
//                               if (item['page'] != null) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder:
//                                         (context) => item['page'] as Widget,
//                                   ),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Menu tidak tersedia'),
//                                   ),
//                                 );
//                               }
//                             }
//                           },
//                         );
//                       }).toList(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Card Informasi
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.info, color: Colors.blue),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'Informasi Penting',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             'Jangan lupa mengerjakan tugas sebelum pukul 23.59 ya!',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
