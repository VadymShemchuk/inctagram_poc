// import 'package:flutter/material.dart';
// import 'package:insta_poc/api/api_constants/api_constants.dart';
// import 'package:insta_poc/api/instagram_api_service.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:insta_poc/presentation/shop_widget.dart';

// class _Constants {
//   static const Map<String, String> heder = {
//     'accept':
//         'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
//     'user-agent':
//         'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36',
//     'upgrade-insecure-requests': '1',
//     'accept-encoding': 'gzip, deflate, br',
//     'accept-language': 'en-US,en;q=0.9,en;q=0.8'
//   };
// }

// class InstagramAPIWebView extends StatelessWidget {
//   const InstagramAPIWebView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // INIT THE INSTAGRAM CLASS
//     final InstagramApiService instagram = InstagramApiService();
//     // INIT THE WEBVIEW
//     final flutterWebviewPlugin = FlutterWebviewPlugin();
//     // OPEN WEBVIEW ACCORDING TO URL GIVEN
//     flutterWebviewPlugin.launch(InstagramApiService.oauthUrl);
//     // LISTEN CHANGES
//     flutterWebviewPlugin.onUrlChanged.listen((String url) async {
//       // IF SUCCESS LOGIN
//       if (url.contains(ApiConstants.redirectUri)) {
//         instagram.getAuthorizationCode(url);
//         instagram.getTokenAndUserID().then((isDone) {
//           if (isDone) {
//             // instagram.getUserProfile().then((isDone) {
//             instagram.getAllMedias().then((medias) {
//               // NOW WE CAN CLOSE THE WEBVIEW
//               flutterWebviewPlugin.close();
//               instagram.exchangeShortToLongToken();
//               // WE PUSH A NEW ROUTE FOR SELECTING OUR MEDIAS
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (BuildContext ctx) {
//                 // ADDING OUR SELECTION PAGE
//                 return ShopSelectionPage(
//                   medias: medias,
//                   // onPressedConfirmation: () {
//                   //   // RETURNING AFTER SELECTION OUR MEDIAS LIST
//                   //   Navigator.of(ctx).pop();
//                   //   Navigator.of(context).pop(medias);
//                   // },
//                 );
//               }));
//             });
//             // });
//           }
//         });
//       }
//     });

//     return WebviewScaffold(
//       resizeToAvoidBottomInset: true,
//       url: InstagramApiService.oauthUrl,
//       headers: _Constants.heder,
//     );
//   }
// }
