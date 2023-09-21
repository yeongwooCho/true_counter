import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

class KakaoPostCode extends StatelessWidget {
  const KakaoPostCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Use callback.
        TextButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => KpostalView(
                    callback: (Kpostal result) {
                      print(result.address);
                    },
                  ),
                ));
          },
          child: Text('Search!'),
        ),

// Not use callback.
        TextButton(
          onPressed: () async {

            dynamic result = await Navigator.of(context).pushNamed(KpostalView.routeName);

            // Kpostal result = await Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => KpostalView(
            //       appBar: DefaultAppBar(title: '주소 검색'),
            //     ),
            //   ),
            // );
            print(result.address);
          },
          child: Text('Search!'),
        ),

// Use local server.
//         KpostalView(
//           useLocalServer: true,
//           // default is false
//           localPort: 8080,
//           // default is 8080
//           kakaoKey: '{your kakao developer app\'s JS key}',
//           // if not declared, only use platform's geocoding
//           callback: (Kpostal result) {
//             print(result);
//           },
//         )
      ],
    );
  }
}
