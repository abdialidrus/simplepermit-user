import 'package:flutter/material.dart';
import 'package:simple_permit_user/home/models/user_type.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class UserTypeMenuItem extends StatelessWidget {
  const UserTypeMenuItem({required this.userType, super.key});

  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
