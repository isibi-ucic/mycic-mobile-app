// import 'package:bloc/bloc.dart';
// import 'package:flutter/widgets.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'banner_event.dart';
// part 'banner_state.dart';
// part 'banner_bloc.freezed.dart';

// class BannerBloc extends Bloc<BannerEvent, BannerState> {
//   BannerBloc() : super(_Initial()) {
//     on<_BannersRequested>(_onBannersRequested);
//     on<_PageChanged>(_onPageChanged);
//   }

//   Future<void> _onBannersRequested(
//     _BannersRequested event,
//     Emitter<BannerState> emit,
//   ) async {
//     emit(const BannerState.loading());

//     final failureOrBanners = await mahas.getBanners();

//     // Gunakan .fold untuk menangani Left (Failure) dan Right (Success)
//     failureOrBanners.fold(
//       (failure) => emit(BannerState.error(message: failure.message)),
//       (banners) {
//         final bannerWidgets =
//             banners.map((banner) => _buildBannerContent(banner)).toList();
//         emit(BannerState.loaded(bannerItems: bannerWidgets));
//       },
//     );
//   }

//   void _onPageChanged(_PageChanged event, Emitter<BannerState> emit) {
//     // Pastikan state saat ini adalah Loaded sebelum mengubah index
//     state.whenOrNull(
//       loaded: (bannerItems, _) {
//         emit(
//           BannerState.loaded(
//             bannerItems: bannerItems,
//             currentIndex: event.newIndex,
//           ),
//         );
//       },
//     );
//   }

//   // Helper untuk membangun UI dari data model
//   Widget _buildBannerContent(BannerModel banner) {
//     // ... (Sama seperti contoh sebelumnya, menggunakan data dari `banner`)
//     return Stack(
//       children: [
//         Image.network(
//           banner.imageUrl,
//           fit: BoxFit.cover,
//           width: double.infinity,
//         ),
//         Container(color: Colors.black.withOpacity(0.4)),
//         Align(
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 banner.title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 banner.subtitle,
//                 style: const TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
