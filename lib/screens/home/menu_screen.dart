import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_homework/configs/themes/app_colors.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';
import 'package:study_homework/controller/zoom_drawer_controller.dart';

class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: UIparameters.mobileScreenPadding,
        width: double.maxFinite,
        //decoration: BoxDecoration(gradient: mainGradient()),
        child: Theme(
            data: ThemeData(
                textButtonTheme: TextButtonThemeData(
                    style:
                        TextButton.styleFrom(foregroundColor: Colors.white))),
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      child: BackButton(
                        color: Colors.white,
                        onPressed: () {
                          controller.toogleDrawer();
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.2),
                    child: Column(
                      children: [
                        Obx(() => controller.user.value == null
                            ? SizedBox()
                            : Text(
                                controller.user.value!.displayName ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: onSurfaceTextColor),
                              )),
                        const Spacer(flex: 1),
                        _DrawerButton(
                            icon: Icons.web,
                            label: 'Website',
                            onPressed: () => controller.website()),
                        _DrawerButton(
                            icon: Icons.facebook,
                            label: 'Facebook',
                            onPressed: () => controller.facebook()),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: _DrawerButton(
                              icon: Icons.email,
                              label: 'Email',
                              onPressed: () => controller.email()),
                        ),
                        Spacer(flex: 4),
                        _DrawerButton(
                            icon: Icons.logout,
                            label: 'Log-Out',
                            onPressed: () => controller.signOut()),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton(
      {super.key, required this.icon, required this.label, this.onPressed});

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 15),
      label: Text(label),
    );
  }
}
