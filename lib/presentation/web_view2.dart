// import 'package:flutter/material.dart';
// import 'package:insta_poc/api/instagram_api_service.dart';
// import 'package:insta_poc/api/media_model.dart';
// import 'package:insta_poc/presentation/shop_widget.dart';

// class WebView2 extends StatefulWidget {
//   const WebView2({super.key});

//   @override
//   State<WebView2> createState() => _WebView2State();
// }

// class _WebView2State extends State<WebView2> {
//   InstagramApiService instagramApi = InstagramApiService();
//   List<InstagramMediaModel> medias = [];
//   @override
//   void initState() {
//     instagramApi.getAllMedias().then((value) {
//       medias = value;
//       setState(() {});
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return medias.isEmpty
//         ? const Center(child: CircularProgressIndicator())
//         : ShopSelectionPage(
//             // medias: medias,
//           );
//   }
// }
