enum StatusModel {
  none('NONE'),
  past('PAST'),
  now('NOW'),
  future('FUTURE');

  const StatusModel(this.label);

  final String label;

  static StatusModel getType({required String type}) {
    switch (type) {
      case 'PAST':
        return StatusModel.past;
      case 'NOW':
        return StatusModel.now;
      case 'FUTURE':
        return StatusModel.future;
      default:
        return StatusModel.none;
    }
  }
}
