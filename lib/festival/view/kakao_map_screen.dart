import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';

class KakaoMapScreen extends StatefulWidget {
  final LatLng latLng;

  const KakaoMapScreen({
    Key? key,
    required this.latLng,
  }) : super(key: key);

  @override
  State<KakaoMapScreen> createState() => _KakaoMapScreenState();
}

class _KakaoMapScreenState extends State<KakaoMapScreen> {
  Set<Marker> markers = {}; // 마커 변수
  KakaoMapController? mapController;

  @override
  void dispose() {
    mapController?.clear();
    mapController = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '행사 위치',
      ),
      child: KakaoMap(
        onMapCreated: ((KakaoMapController controller) async {
          mapController = controller;

          markers.add(
            Marker(
              markerId: UniqueKey().toString(),
              latLng: await mapController!.getCenter(),
              markerImageSrc:
                  "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Hand%20gestures/Backhand%20Index%20Pointing%20Down%20Light%20Skin%20Tone.png",
              height: 100,
              width: 100,
              offsetX: 60,
              offsetY: 100,
            ),
          );

          setState(() {});
        }),
        markers: markers.toList(),
        center: widget.latLng, // LatLng(37.3608681, 126.9306506),
      ),
    );
  }
}
