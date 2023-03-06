import 'package:cached_network_image/cached_network_image.dart';
import 'package:creator_shop/di/di_config.dart';
import 'package:creator_shop/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../data/model/user_model.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const path = "ProfileScreen";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = getIt<UserModel>();
    return Padding(
      padding: const EdgeInsets.all(hPaddingFromScreen),
      child: Column(
        children: [
          Row(children: [
            Text("MY",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                )),
            const SizedBox(width: 10),
            Text("PROFILE",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                )),
          ]),
          const SizedBox(height: 50),
          Column(
            children: [
              CircleAvatar(
                  child: CachedNetworkImage(
                imageUrl:
                    "https://snoidcdnems06.cdnsrv.jio.com/c.saavncdn.com/882/Xxxtentacion-English-2018-20180627045322-500x500.jpg",
                width: 200,
                height: 200,
              )),
              const SizedBox(height: 50),
              Row(
                children: [Text("${user.firstName} ${user.lastName}",style: theme.textTheme.bodyLarge),
                IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
