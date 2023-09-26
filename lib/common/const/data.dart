enum LocationLabel {
  all('전체'),
  seoul('서울특별시'),
  pusan('부산광역시'),
  daegu('대구광역시'),
  incheon('인천광역시'),
  gwangju('광주광역시'),
  daejeon('대전광역시'),
  ulsan('울산광역시'),
  sejong('세종특별자치시'),
  gyeonggi('경기도'),
  gangwon('강원도'),
  chungcheongNorth('충청북도'),
  chungcheongSouth('충청남도'),
  jeollaNorth('전라북도'),
  jeollaSouth('전라남도'),
  gyeongsangNorth('경상북도'),
  gyeongsangSouth('경상남도'),
  jeju('제주특별자치도');

  const LocationLabel(this.label);

  final String label;

  static getLabels() => [
        LocationLabel.all.label,
        LocationLabel.seoul.label,
        LocationLabel.pusan.label,
        LocationLabel.daegu.label,
        LocationLabel.incheon.label,
        LocationLabel.gwangju.label,
        LocationLabel.daejeon.label,
        LocationLabel.ulsan.label,
        LocationLabel.sejong.label,
        LocationLabel.gyeonggi.label,
        LocationLabel.gangwon.label,
        LocationLabel.chungcheongNorth.label,
        LocationLabel.chungcheongSouth.label,
        LocationLabel.jeollaNorth.label,
        LocationLabel.jeollaSouth.label,
        LocationLabel.gyeongsangNorth.label,
        LocationLabel.gyeongsangSouth.label,
        LocationLabel.jeju.label,
      ];
}
