class UserType {
  const UserType({required this.name, required this.icon});

  final String name;
  final String icon;
}

List<UserType> userTypes = [
  const UserType(name: 'Applicant/Owner', icon: 'home-menu-applicant'),
  const UserType(name: 'Contractor', icon: 'home-menu-contractor'),
  const UserType(name: 'Community', icon: 'home-menu-community'),
  const UserType(name: 'Construction', icon: 'home-menu-construction'),
  const UserType(name: 'Design Professional', icon: 'home-menu-design'),
  const UserType(name: 'Jurisdiction Employee', icon: 'home-menu-jurisdiction'),
];
