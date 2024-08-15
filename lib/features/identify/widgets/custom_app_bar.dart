import 'package:flora_sense/features/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.themeCubit,
  });

  final ThemeCubit themeCubit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.info_outlined),
        onPressed: () {},
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Center(
        child: Text('FloraSense',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      actions: [
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            IconData icon;
            switch (themeMode) {
              case ThemeMode.dark:
                icon = Icons.wb_sunny; // Light mode icon
                break;
              case ThemeMode.light:
                icon = Icons.nights_stay; // Dark mode icon
                break;
              case ThemeMode.system:
              default:
                icon = Icons.brightness_6; // System mode icon
                break;
            }
            return IconButton(
              icon: Icon(icon),
              onPressed: () => themeCubit.toggleTheme(),
              color: Theme.of(context).iconTheme.color,
            );
          },
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
