import 'package:flutter/material.dart';
import 'package:stacked_permit_user_app/ui/common/app_typography.dart';

class UserType {
  const UserType({required this.name, required this.icon});

  final String name;
  final String icon;
}

List<UserType> userTypes = [
  const UserType(name: 'Contractor', icon: 'home-menu-contractor'),
  const UserType(name: 'Developer', icon: 'home-menu-developer'),
  const UserType(name: 'Owner', icon: 'home-menu-owner'),
  const UserType(name: 'Design Professional', icon: 'home-menu-design-pro'),
  const UserType(
    name: 'Government Representative',
    icon: 'home-menu-government-rep',
  ),
  const UserType(
    name: 'Permit Specialist',
    icon: 'home-menu-permit-specialist',
  ),
];

class UserTypeMenuItem extends StatelessWidget {
  const UserTypeMenuItem({
    required this.userType,
    required this.onTap,
    super.key,
  });

  final UserType userType;
  final void Function(UserType) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(userType),
      child: Container(
        width: 155,
        height: 175,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(5, 5),
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/${userType.icon}.png',
              width: double.infinity,
              height: 134,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 8,
                  bottom: 8,
                ),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      userType.name,
                      style: ktsMediumMedium.copyWith(height: 1.4),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
