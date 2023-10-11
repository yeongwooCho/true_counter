enum RoleType {
  user('USER'),
  admin('ADMIN');

  const RoleType(this.label);

  final String label;

  static RoleType getType({required String type}) {
    switch (type) {
      case 'ADMIN':
        return RoleType.admin;
      default:
        return RoleType.user;
    }
  }
}
