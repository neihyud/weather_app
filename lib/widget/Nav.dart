import 'package:flutter/material.dart';

import '../location.dart';

class buildMenuItem extends StatelessWidget {
  const buildMenuItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Sửa địa điểm'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LocationPage();
          }));
        },
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Item 1'),
        onTap: () {},
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Contribute'),
        onTap: () {},
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Vote'),
        onTap: () {},
      ),
    ]);
  }
}
