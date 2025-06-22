import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:main/domain/models/folder.dart';
import 'package:main/presentation/screens/edit_folder/edit_folder_screen.dart';

class EditFolderPage extends StatelessWidget {
  const EditFolderPage({super.key, required folder});

  @override
  Widget build(BuildContext context) {
    final folder = GoRouterState.of(context).extra as Folder;
    return EditFolderScreen(folder: folder);
  }
}
